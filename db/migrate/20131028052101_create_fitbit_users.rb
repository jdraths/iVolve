class CreateFitbitUsers < ActiveRecord::Migration
  def change
    create_table :fitbit_users do |t|
    	t.string :about_me
    	t.string :avatar
    	t.string :avatar_onefifty
    	t.string :user_city
    	t.string :user_country
    	t.string :date_of_birth
    	t.string :display_name
    	t.string :distance_unit
    	t.string :encoded_id
    	t.string :full_name
    	t.string :gender
    	t.string :glucose_unit
    	t.string :height
    	t.string :height_unit
    	t.string :nickname
    	t.string :locale
    	t.string :member_since
    	t.string :utc_offset
    	t.string :home_state
    	t.string :stride_length_run
    	t.string :stride_length_walk
    	t.string :timezone
    	t.string :water_unit
    	t.string :weight
    	t.string :weight_unit

      t.timestamps
    end
  end
end
