class PlatformRecord < ActiveRecord::Base
  self.primary_key = 'txid'

  has_many :refunded_items, primary_key: :tuid, foreign_key: :tuid
  has_many :transactions, primary_key: :tuid, foreign_key: :tuid
  has_many :transactions_reference, primary_key: :tuid, foreign_key: :tuid


  def batch_update_platform
    last_batch_time = Time.now
    update_array = []

    transactions_data = PlatformRecord.select("platform_records.tuid, platform_records.txid, updated_at, order_data, transactions.amount, response_reason_code, auth_verification_code, method_of_payment, status, platform_status, created_at, authorized_at, captured_at, venue_id, terminal_id, is_synchronous, mcc_code, transactions.ext_data as t_ext_data, r.record_id, r.items, r.monetary_data, r.ext_data as r_ext_data")
    .joins(:transactions)
    .joins("LEFT OUTER JOIN refunded_items r on (r.tuid = platform_records.tuid and r.platform_synced = b'0')")
    update_array = transactions_data.collect { |t| t.as_json }

    send_transactions(update_array)
    update_after_platform_sync(transactions_data)
    remove_platform_records(transactions_data)
  end

  def send_transactions(update_array)
    base_url = APP_CONFIG['platform_rails_url']
    response = RestClient.post("#{base_url}/batch", { transactions: update_array }.to_json, :content_type => :json, :accept => :json)
  end

  def update_after_platform_sync(transactions_data)
    records_to_remove = transactions_data.map(&:txid)
    PlatformRecord.destroy_all(txid: records_to_remove)
  end

  def remove_platform_records(transactions_data, platform_records_data)
    records_to_remove = []
    for pr in platform_records_data
      for t in transactions_data
        if pr.tuid == t.tuid && t.status == t.platform_status
          records_to_remove.push(pr.txid)
        end
      end
    end
    PlatformRecord.destroy_all(txid: records_to_remove)
  end
end
