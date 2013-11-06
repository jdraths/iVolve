class ChangeTextLimitInAuthorizations < ActiveRecord::Migration
  	def up
  		change_table :authorizations do |t|
  			t.change :oauth_token, :text, :limit => nil
  			t.change :oauth_secret, :text, :limit => nil
  		end
  	end

  	def down
  		change_table :authorizations do |t|
  			t.change :oauth_secret, :text
  			t.change :oauth_token, :text
  		end
  	end
end
