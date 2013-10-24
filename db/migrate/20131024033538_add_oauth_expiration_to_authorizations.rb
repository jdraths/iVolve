class AddOauthExpirationToAuthorizations < ActiveRecord::Migration
  def change
  	add_column :authorizations, :oauth_expires_at, :datetime
  end
end
