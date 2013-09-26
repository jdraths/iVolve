require 'spec_helper'

describe Activity do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:achievement) { FactoryGirl.create(:activity) }
  before { @activity = user.activities.build(achievement_id: achievement.id,
            value: "12345", app_log_id: "12345", time: "12345", description: "completed activity") }

  subject { @activity }

  it { should respond_to(:user_id) }
  it { should respond_to(:achievement_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should respond_to(:value) }
  it { should respond_to(:app_log_id) }
  it { should respond_to(:time) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @activity.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with missing achievement_id" do
    before { @activity.achievement_id = nil }
    it { should_not be_valid }
  end

  describe "with missing value" do
    before { @activity.value = " " }
    it { should_not be_valid }
  end

  describe "with missing app_log_id" do
    before { @activity.app_log_id = " " }
    it { should_not be_valid }
  end

  describe "with missing time" do
    before { @activity.time = " " }
    it { should_not be_valid }
  end

  describe "with missing description" do
    before { @activity.description = " " }
    it { should_not be_valid }
  end
end
