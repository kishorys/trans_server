class TransactionsReference < ActiveRecord::Base
  self.table_name = 'transactions_reference'

  belongs_to :platform_record, primary_key: :tuid, foreign_key: :tuid
end
