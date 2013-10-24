class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
      t.string :uid
      t.string :name
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :gender
      t.string :locale
      t.string :languages
      t.string :profile_url
      t.string :screen_name
      t.string :third_party_id
      t.boolean :installed
      t.string :timezone
      t.string :updated_time
      t.boolean :verified
      t.string :bio
      t.string :birthday
      t.string :cover_photo
      t.string :currency
      t.string :devices
      t.string :education
      t.string :email
      t.string :hometown
      t.string :interested_in
      t.string :location
      t.string :political
      t.string :favorite_athletes
      t.string :favorite_teams
      t.string :profile_pic
      t.string :quotes
      t.string :relationship_status
      t.string :religion
      t.string :significant_other
      t.string :website
      t.string :work

      t.timestamps
    end
  end
end
