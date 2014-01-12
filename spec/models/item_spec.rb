require 'spec_helper'

describe Item do
  let(:item){ FactoryGirl.create(:item) }

  it "has a valid factory" do
    item.should be_valid
  end

  describe "errors on required attributes" do
    it "should be invalid without name" do
      Item.new.should have(1).error_on(:name)
    end

    it "should be invalid without an estimated_time" do
      Item.new.should have(1).error_on(:estimated_time)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:estimated_time) }
  end

  describe "time methods" do
    before do
      daily_commit = FactoryGirl.create(:commit, item_id: item.id)
    end

    it "should return the seconds commited per day" do
      Item.today_seconds.should eq(60)
    end
  end

  describe "relationships" do
    it { should have_many(:commits) }
    it { should have_one(:recording_item) }
    it { should belong_to(:user) }
  end
end