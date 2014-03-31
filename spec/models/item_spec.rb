require 'spec_helper'

describe Item do
  let(:item){ FactoryGirl.create(:item) }

  it "has a valid factory" do
    item.should be_valid
  end

  describe "errors on required attributes" do
    it "should be invalid without name" do
      Item.new.should have(1).errors_on(:name)
    end

    it "should be invalid without an estimated_time" do
      Item.new.should have(2).errors_on(:estimated_time)
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

    it "should return the seconds commited per week" do
      FactoryGirl.create(:commit, item_id: item.id)
      Item.week_seconds.should eq(120)
    end

    it "should eturn the seconds commited by an item this week" do
      item.calculate_week_time.should eq(60)
    end

    it "should return an string with format #h/#m/#s" do
      Item.format_time(3960).should eq('1h:6m')
    end

    it "should return the time commited today in format #h/#m/#s" do
      Item.today_time.should eq('0h:1m')
    end

    it "should return the time commited this week in format #h/#m/#s" do
      FactoryGirl.create(:commit, item_id: item.id)
      Item.today_time.should eq('0h:2m')
    end
  end

  describe "relationships" do
    it { should have_many(:commits) }
    it { should have_one(:recording_item) }
    it { should belong_to(:user) }
  end
end