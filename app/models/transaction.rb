class Transaction < ActiveRecord::Base
  self.primary_key = 'tuid'

  belongs_to :platform_record, primary_key: :tuid, foreign_key: :tuid

  after_create :create_platform_record


  private

  def create_platform_record
    PlatformRecord.create(tuid: self.tuid)
  end
end
