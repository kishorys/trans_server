require 'rails_helper'

RSpec.describe PlatformRecord, type: :model do
  context "#Add" do
    it "should return true if an entry exists" do
      expect(PlatformRecord.count).to eq(0)
      FactoryGirl.create(:platform_record)
      expect(PlatformRecord.count).to eq(1)
    end
  end

  context "#Add" do
    it "should check whether records are getting saved and deleted correctly" do
      1.upto(1000) do |x|
        FactoryGirl.create(:platform_record)
      end
      expect(PlatformRecord.count).to eq(1000)
      PlatformRecord.delete_all
      expect(PlatformRecord.count).to eq(0)
    end
  end

  context "Create Transaction" do
    it "should create its associated platform_records" do
      expect(PlatformRecord.count).to eq(0)
      1.upto(100) do |x|
        FactoryGirl.create(:transaction)
      end
      expect(PlatformRecord.count).to eq(100)
    end
  end
end
