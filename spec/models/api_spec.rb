require 'spec_helper'

describe Api do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @api = user.apis.build(company: "company name", company_id: 1, 
            con_key: "12345", con_secret: "12345", access_token: "12345", 
            access_secret: "completed activity") }

  subject { @api }

  it { should respond_to(:company) }
  it { should respond_to(:company_id) }
  it { should respond_to(:con_key) }
  it { should respond_to(:con_secret) }
  it { should respond_to(:access_token) }
  it { should respond_to(:access_secret) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @api.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when company is not present" do
  	before { @api.company = " " }
  	it { should_not be_valid }
  end

  describe "when access_token is not present" do
  	before { @api.access_token = " " }
  	it { should_not be_valid }
  end

  describe "when access_secret is not present" do
  	before { @api.access_secret = " " }
  	it { should_not be_valid }
  end
end
