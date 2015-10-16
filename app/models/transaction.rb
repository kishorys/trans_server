class Transaction < ActiveRecord::Base
  self.primary_key = 'tuid'

  belongs_to :platform_record, primary_key: :tuid, foreign_key: :tuid
end
