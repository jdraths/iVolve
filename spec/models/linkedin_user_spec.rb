require 'spec_helper'

describe LinkedinUser do
  
  before do
  	@linkedin_user = LinkedinUser.new(first_name: "Example", last_name: "User", uid: "12345")
  end

  subject { @linkedin_user }

  it { should respond_to(:uid) }

  it { should be_valid }

  describe "when uid is not present" do
  	before { @linkedin_user.uid = " " }
  	it { should_not be_valid }
  end


  #Other validations...
  # it should save data correctly as integer vs string...
  

end
