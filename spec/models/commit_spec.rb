require 'spec_helper'

describe Commit do
  let(:commit){ FactoryGirl.create(:commit) }

  it "has a valid factory" do
    commit.should be_valid
  end

  describe "errors on required attributes" do
    it "should be invalid without begin_time" do
      Commit.new.should have(1).error_on(:begin_time)
    end
    it "should be invalid without end_time" do
      Commit.new.should have(1).error_on(:end_time)
    end
    it "should be invalid without spent_time" do
      Commit.new.should have(1).error_on(:spent_time)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:begin_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:spent_time) }
  end

  describe "relationships" do
    it { should belong_to(:item) }
  end
end
