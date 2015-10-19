class PlatformRecord < ActiveRecord::Base
  self.primary_key = 'txid'

  has_many :refunded_items, primary_key: :tuid, foreign_key: :tuid
  has_many :transactions, primary_key: :tuid, foreign_key: :tuid
  has_many :transactions_reference, primary_key: :tuid, foreign_key: :tuid


  def batch_update_platform
    last_batch_time = Time.now
    update_array = []

    transactions = PlatformRecord.select("platform_records.tuid, platform_records.txid, t.updated_at, t.order_data, t.amount, t.response_reason_code, t.auth_verification_code, t.method_of_payment, t.status, t.platform_status, t.created_at, t.authorized_at, t.captured_at, t.venue_id, t.terminal_id, t.is_synchronous, t.mcc_code, t.ext_data as t_ext_data, r.record_id, r.items, r.monetary_data, r.ext_data as r_ext_data")
    .joins("INNER JOIN transactions t on t.tuid = platform_records.tuid")
    .joins("LEFT OUTER JOIN refunded_items r on (r.tuid = platform_records.tuid and r.platform_synced = b'0')")
    update_array = transactions.collect { |t| t.as_json }

    send_transactions(update_array)
    # updateAfterPlatformSync(transactions)
    # removePlatformRecords(transactions)
  end

  def send_transactions(update_array)
    base_url = APP_CONFIG['platform_rails_url']
    response = RestClient.post("#{base_url}/batch", { transactions: update_array }.to_json, :content_type => :json, :accept => :json)
  end
end
