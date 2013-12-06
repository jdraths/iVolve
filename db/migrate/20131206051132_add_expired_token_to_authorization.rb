class AddExpiredTokenToAuthorization < ActiveRecord::Migration
  def self.up
  	change_table :authorizations do |t|
  		t.boolean :expired_token, default: false
  	end
  end

  def self.down
  	change_table :authorizations do |t|
  		t.remove :expired_token
  	end
  end
end
