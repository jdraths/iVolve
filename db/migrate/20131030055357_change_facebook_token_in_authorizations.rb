class ChangeFacebookTokenInAuthorizations < ActiveRecord::Migration
  def up
  	change_table :authorizations do |t|
  		t.change :oauth_token, :text
  		t.change :oauth_secret, :text
  	end
  end

  def down
  	change_table :authorizations do |t|
  		t.change :oauth_secret, :string
  		t.change :oauth_token, :string
  	end
  end
end
