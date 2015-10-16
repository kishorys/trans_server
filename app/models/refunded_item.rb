class RefundedItem < ActiveRecord::Base
  self.primary_key = 'record_id'

  belongs_to :platform_record, primary_key: :tuid, foreign_key: :tuid
end
