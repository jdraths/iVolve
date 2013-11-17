class CreateIvolveIndices < ActiveRecord::Migration
  def change
    create_table :ivolve_indices do |t|
    	t.integer :iv_total
    	t.integer :iv_physical
    	t.integer :iv_intellectual
    	t.integer :iv_social
    	t.integer :iv_spiritual
    	t.integer :iv_creative
    	t.integer :iv_emotional
    	t.integer :male_total
    	t.integer :male_physical
    	t.integer :male_intellectual
    	t.integer :male_social
    	t.integer :male_spiritual
    	t.integer :male_creative
    	t.integer :male_emotional
    	t.integer :female_total
    	t.integer :female_physical
    	t.integer :female_intellectual
    	t.integer :female_social
    	t.integer :female_spiritual
    	t.integer :female_creative
    	t.integer :female_emotional
    	t.integer :twitter_users_total
    	t.integer :facebook_users_total
    	t.integer :instagram_users_total
    	t.integer :fitbit_users_total
    	t.integer :iv_twitter_friends
    	t.integer :iv_twitter_follwers
    	t.integer :iv_twitter_tweets_sent
    	t.integer :iv_twitter_tweets_favd
    	t.integer :iv_twitter_lists
    	t.integer :iv_facebook_friends
    	t.integer :iv_facebook_likes_sent
    	t.integer :iv_facebook_posts
    	t.integer :iv_facebook_statuses
    	t.integer :iv_facebook_achievements
    	t.integer :iv_facebook_subscribers
    	t.integer :iv_facebook_subscribed_to_you
    	t.integer :iv_instagram_followers
    	t.integer :iv_instagram_following
    	t.integer :iv_instagram_shared
    	t.integer :iv_instagram_likes_sent
    	t.integer :iv_fitbit_height
    	t.integer :iv_fitbit_weight
    	t.integer :iv_fitbit_stride_length_run
    	t.integer :iv_fitbit_stride_length_walk
    	t.integer :iv_fitbit_life_tot_active_score
    	t.integer :iv_fitbit_best_tot_active_score
    	t.integer :iv_fitbit_life_tot_cal_out
    	t.integer :iv_fitbit_best_tot_cal_out
    	t.integer :iv_fitbit_life_tot_dist
    	t.integer :iv_fitbit_best_tot_dist
    	t.integer :iv_fitbit_life_tot_steps
    	t.integer :iv_fitbit_best_tot_steps

      t.timestamps
    end
  end
end
