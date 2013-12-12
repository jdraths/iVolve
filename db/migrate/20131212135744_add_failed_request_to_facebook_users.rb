class AddFailedRequestToFacebookUsers < ActiveRecord::Migration
  def self.up
  	change_table :facebook_users do |t|
  		t.boolean :failed_request, default: false
  		t.boolean :deauthed_facebook, default: false
  	end
  end

  def self.down
  	change_table :facebook_users do |t|
  		t.remove :deauthed_facebook
  		t.remove :failed_request
  	end
  end
end
