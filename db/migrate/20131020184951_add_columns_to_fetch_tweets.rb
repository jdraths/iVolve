class AddColumnsToFetchTweets < ActiveRecord::Migration
  def change
  	add_column :fetch_tweets, :from_user_id, 				:integer
  	add_column :fetch_tweets, :from_user_name, 				:string
  	add_column :fetch_tweets, :in_reply_to_attrs_id, 		:string
  	add_column :fetch_tweets, :in_reply_to_screen_name, 	:string
  	add_column :fetch_tweets, :in_reply_to_status_id_str, 	:string
  	add_column :fetch_tweets, :in_reply_to_user_id_str, 	:string
  	add_column :fetch_tweets, :lang, 						:string
  	add_column :fetch_tweets, :repliers, 					:string
  	add_column :fetch_tweets, :repliers_count, 				:integer
  	add_column :fetch_tweets, :retweeted, 					:boolean, default: false
  	add_column :fetch_tweets, :retweeters, 					:string
  	add_column :fetch_tweets, :source, 						:string
  	add_column :fetch_tweets, :to_user, 					:string
  	add_column :fetch_tweets, :to_user_id, 					:string
  	add_column :fetch_tweets, :to_user_name, 				:string
  	add_column :fetch_tweets, :geo, 						:string
  	add_column :fetch_tweets, :hashtags, 					:string
  	add_column :fetch_tweets, :media, 						:string
  	add_column :fetch_tweets, :metadata, 					:string
  	add_column :fetch_tweets, :place_attributes, 			:string
  	add_column :fetch_tweets, :place_country, 				:string
  	add_column :fetch_tweets, :place_full_name, 			:string
  	add_column :fetch_tweets, :place_url, 					:string
  	add_column :fetch_tweets, :place_type, 					:string
  	add_column :fetch_tweets, :symbols, 					:string
  	add_column :fetch_tweets, :incl_url, 					:string

  end
end
