module StatsHelper
# => the below instance variables are accessible in:
# => users_controller.rb & static_pages_controller.rb due to the include StatsHelper line in each controller.

    # => stats_view is invoked when viewing the user's own profile or the home page.
    # => stats_view compares the user to the index.
    # => see users_controller.rb show action for usage.
    def stats_view
        if signed_in?
                @ivolveindex = IvolveIndex.first
            if linkedin?
                @linkedin_int_connections = @linkedin_auth_user.connections_size
                @linkedin_int_group_memberships = @linkedin_auth_user.group_memberships_size
                @linkedin_int_job_suggestions = @linkedin_auth_user.job_suggestions_size
                @linkedin_int_job_bookmarks = @linkedin_auth_user.job_bookmarks_size
                @linkedin_int_shares = @linkedin_auth_user.shares_size
                @linkedin_avg_connections = @ivolveindex.iv_linkedin_connections_int
                @linkedin_avg_group_memberships = @ivolveindex.iv_linkedin_group_memberships_int
                @linkedin_avg_job_suggestions = @ivolveindex.iv_linkedin_job_suggestions_int
                @linkedin_avg_job_bookmarks = @ivolveindex.iv_linkedin_job_bookmarks_int
                @linkedin_avg_shares = @ivolveindex.iv_linkedin_shares_int
            else
                @linkedin_int_connections = 0
                @linkedin_avg_connections = @ivolveindex.iv_linkedin_connections_int
                @linkedin_int_group_memberships = 0
                @linkedin_avg_group_memberships = @ivolveindex.iv_linkedin_group_memberships_int
                @linkedin_int_job_suggestions = 0
                @linkedin_avg_job_suggestions = @ivolveindex.iv_linkedin_job_suggestions_int
                @linkedin_int_job_bookmarks = 0
                @linkedin_avg_job_bookmarks = @ivolveindex.iv_linkedin_job_bookmarks_int
                @linkedin_int_shares = 0
                @linkedin_avg_shares = @ivolveindex.iv_linkedin_shares_int
            end
            if @linkedin_int_connections.nil?
                @linkedin_int_connections = 0
            end
            if @linkedin_int_group_memberships.nil?
                @linkedin_int_group_memberships = 0
            end
            if @linkedin_int_job_suggestions.nil?
                @linkedin_int_job_suggestions = 0
            end
            if @linkedin_int_job_bookmarks.nil?
                @linkedin_int_job_bookmarks = 0
            end
            if @linkedin_int_shares.nil?
                @linkedin_int_shares = 0
            end
            if @linkedin_avg_connections.nil?
                @linkedin_avg_connections = 0
            end
            if @linkedin_avg_group_memberships.nil?
                @linkedin_avg_group_memberships = 0
            end
            if @linkedin_avg_job_suggestions.nil?
                @linkedin_avg_job_suggestions = 0
            end
            if @linkedin_avg_job_bookmarks.nil?
                @linkedin_avg_job_bookmarks = 0
            end
            if @linkedin_avg_shares.nil?
                @linkedin_avg_shares = 0
            end

            if twitter?   # is current_user an authorized twitter user with data saved?
                @twitter_int_friends = @twitter_auth_user.friends_int_count
                @twitter_int_followers = @twitter_auth_user.followers_int_count
                @twitter_int_sent = @twitter_auth_user.tweet_int_count
                @twitter_int_favorites = @twitter_auth_user.favorite_int_count
                @twitter_int_lists = @twitter_auth_user.listed_int_count
                @twitter_num_retweets_of_me = @twitter_auth_user.num_retweets_of_me
                @twitter_num_mentions_of_me = @twitter_auth_user.num_mentions_of_me
                @twitter_num_retweets_by_me = @twitter_auth_user.num_retweets_by_me
                @twitter_avg_friends = @ivolveindex.iv_twitter_friends
                @twitter_avg_followers = @ivolveindex.iv_twitter_follwers
                @twitter_avg_sent = @ivolveindex.iv_twitter_tweets_sent
                @twitter_avg_fav = @ivolveindex.iv_twitter_tweets_favd
                @twitter_avg_lists = @ivolveindex.iv_twitter_lists
                @twitter_avg_retweets_of_me = @ivolveindex.iv_twitter_retweets_of_me
                @twitter_avg_mentions_of_me = @ivolveindex.iv_twitter_mentions_of_me
                @twitter_avg_retweets_by_me = @ivolveindex.iv_twitter_retweets_by_me
            else
                @twitter_int_friends = 0
                @twitter_avg_friends = @ivolveindex.iv_twitter_friends
                @twitter_int_followers = 0
                @twitter_avg_followers = @ivolveindex.iv_twitter_follwers
                @twitter_int_sent = 0
                @twitter_avg_sent = @ivolveindex.iv_twitter_tweets_sent
                @twitter_int_favorites = 0
                @twitter_avg_fav = @ivolveindex.iv_twitter_tweets_favd
                @twitter_int_lists = 0
                @twitter_avg_lists = @ivolveindex.iv_twitter_lists
                @twitter_num_retweets_of_me = 0
                @twitter_avg_retweets_of_me = @ivolveindex.iv_twitter_retweets_of_me
                @twitter_num_mentions_of_me = 0
                @twitter_avg_mentions_of_me = @ivolveindex.iv_twitter_mentions_of_me
                @twitter_num_retweets_by_me = 0
                @twitter_avg_retweets_by_me = @ivolveindex.iv_twitter_retweets_by_me
            end
            if @twitter_int_friends.nil?
                @twitter_int_friends = 0
            end
            if @twitter_int_followers.nil?
                @twitter_int_followers = 0
            end
            if @twitter_int_sent.nil?
                @twitter_int_sent = 0
            end
            if @twitter_int_favorites.nil?
                @twitter_int_favorites = 0
            end
            if @twitter_int_lists.nil?
                @twitter_int_lists = 0
            end
            if @twitter_num_retweets_of_me.nil?
                @twitter_num_retweets_of_me = 0
            end
            if @twitter_num_mentions_of_me.nil?
                @twitter_num_mentions_of_me = 0
            end
            if @twitter_num_retweets_by_me.nil?
                @twitter_num_retweets_by_me = 0
            end
            if @twitter_avg_friends.nil?
                @twitter_avg_friends = 0
            end
            if @twitter_avg_followers.nil?
                @twitter_avg_followers = 0
            end
            if @twitter_avg_sent.nil?
                @twitter_avg_sent = 0
            end
            if @twitter_avg_fav.nil?
                @twitter_avg_fav = 0
            end
            if @twitter_avg_lists.nil?
                @twitter_avg_lists = 0
            end
            if @twitter_avg_retweets_of_me.nil?
                @twitter_avg_retweets_of_me = 0
            end
            if @twitter_avg_mentions_of_me.nil?
                @twitter_avg_mentions_of_me = 0
            end
            if @twitter_avg_retweets_by_me.nil?
                @twitter_avg_retweets_by_me = 0
            end

            if facebook? # is current_user an authorized facebook user with data saved?
                @facebook_int_friends = @facebook_auth_user.int_friends
                @facebook_int_likes = @facebook_auth_user.int_likes
                @facebook_int_posts = @facebook_auth_user.int_posts
                @facebook_int_statuses = @facebook_auth_user.int_statuses
                @facebook_int_achievements = @facebook_auth_user.int_achievements
                @facebook_int_subscribers = @facebook_auth_user.int_subscribers
                @facebook_int_subscribed_to = @facebook_auth_user.int_subscribed_to
                @facebook_avg_friends = @ivolveindex.iv_facebook_friends
                @facebook_avg_likes = @ivolveindex.iv_facebook_likes_sent
                @facebook_avg_posts = @ivolveindex.iv_facebook_posts
                @facebook_avg_statuses = @ivolveindex.iv_facebook_statuses
                @facebook_avg_achievements = @ivolveindex.iv_facebook_achievements
                @facebook_avg_subscribers = @ivolveindex.iv_facebook_subscribers
                @facebook_avg_subscribed_to = @ivolveindex.iv_facebook_subscribed_to_you
            else
                @facebook_int_friends = 0
                @facebook_avg_friends = @ivolveindex.iv_facebook_friends
                @facebook_int_likes = 0
                @facebook_avg_likes = @ivolveindex.iv_facebook_likes_sent
                @facebook_int_posts = 0
                @facebook_avg_posts = @ivolveindex.iv_facebook_posts
                @facebook_int_statuses = 0
                @facebook_avg_statuses = @ivolveindex.iv_facebook_statuses
                @facebook_int_achievements = 0
                @facebook_avg_achievements = @ivolveindex.iv_facebook_achievements
                @facebook_int_subscribers = 0
                @facebook_avg_subscribers = @ivolveindex.iv_facebook_subscribers
                @facebook_int_subscribed_to = 0
                @facebook_avg_subscribed_to = @ivolveindex.iv_facebook_subscribed_to_you
            end
            if @facebook_int_friends.nil?
                @facebook_int_friends = 0
            end
            if @facebook_int_likes.nil?
                @facebook_int_likes = 0
            end
            if @facebook_int_posts.nil?
                @facebook_int_posts = 0
            end
            if @facebook_int_statuses.nil?
                @facebook_int_statuses = 0
            end
            if @facebook_int_achievements.nil?
                @facebook_int_achievements = 0
            end
            if @facebook_int_subscribers.nil?
                @facebook_int_subscribers = 0
            end
            if @facebook_int_subscribed_to.nil?
                @facebook_int_subscribed_to = 0
            end
            if @facebook_avg_friends.nil?
                @facebook_avg_friends = 0
            end
            if @facebook_avg_likes.nil?
                @facebook_avg_likes = 0
            end
            if @facebook_avg_posts.nil?
                @facebook_avg_posts = 0
            end
            if @facebook_avg_statuses.nil?
                @facebook_avg_statuses = 0
            end
            if @facebook_avg_achievements.nil?
                @facebook_avg_achievements = 0
            end
            if @facebook_avg_subscribers.nil?
                @facebook_avg_subscribers = 0
            end
            if @facebook_avg_subscribed_to.nil?
                @facebook_avg_subscribed_to = 0
            end

            if instagram?
                @instagram_int_followers = @instagram_auth_user.int_followers
                @instagram_int_following = @instagram_auth_user.int_following
                @instagram_int_media = @instagram_auth_user.int_media
                @instagram_int_likes_out = @instagram_auth_user.int_likes_out
                @instagram_avg_followers = @ivolveindex.iv_instagram_followers
                @instagram_avg_following = @ivolveindex.iv_instagram_following
                @instagram_avg_media = @ivolveindex.iv_instagram_shared
                @instagram_avg_likes_out = @ivolveindex.iv_instagram_likes_sent
            else
                @instagram_int_followers = 0
                @instagram_avg_followers = @ivolveindex.iv_instagram_followers
                @instagram_int_following = 0
                @instagram_avg_following = @ivolveindex.iv_instagram_following
                @instagram_int_media = 0
                @instagram_avg_media = @ivolveindex.iv_instagram_shared
                @instagram_int_likes_out = 0
                @instagram_avg_likes_out = @ivolveindex.iv_instagram_likes_sent
            end
            if @instagram_int_followers.nil?
                @instagram_int_followers = 0
            end
            if @instagram_int_following.nil?
                @instagram_int_following = 0
            end
            if @instagram_int_media.nil?
                @instagram_int_media = 0
            end
            if @instagram_int_likes_out.nil?
                @instagram_int_likes_out = 0
            end
            if @instagram_avg_followers.nil?
                @instagram_avg_followers = 0
            end
            if @instagram_avg_following.nil?
                @instagram_avg_following = 0
            end
            if @instagram_avg_media.nil?
                @instagram_avg_media = 0
            end
            if @instagram_avg_likes_out.nil?
                @instagram_avg_likes_out = 0
            end

            if foursquare?
                @foursquare_friends_count = @foursquare_auth_user.friends_count
                @foursquare_following_count = @foursquare_auth_user.following_count
                @foursquare_checkins_count = @foursquare_auth_user.checkins_count
                @foursquare_badges_count = @foursquare_auth_user.badges_count
                @foursquare_mayor_count = @foursquare_auth_user.mayor_count
                @foursquare_tips_count = @foursquare_auth_user.tips_count
                @foursquare_photos_count = @foursquare_auth_user.photos_count
                @foursquare_avg_friends = @ivolveindex.iv_foursquare_friends
                @foursquare_avg_following = @ivolveindex.iv_foursquare_following
                @foursquare_avg_checkins = @ivolveindex.iv_foursquare_checkins
                @foursquare_avg_badges = @ivolveindex.iv_foursquare_badges
                @foursquare_avg_mayors = @ivolveindex.iv_foursquare_mayor
                @foursquare_avg_tips = @ivolveindex.iv_foursquare_tips
                @foursquare_avg_photos = @ivolveindex.iv_foursquare_photos
            else
                @foursquare_friends_count = 0
                @foursquare_avg_friends = @ivolveindex.iv_foursquare_friends
                @foursquare_following_count = 0
                @foursquare_avg_following = @ivolveindex.iv_foursquare_following
                @foursquare_checkins_count = 0
                @foursquare_avg_checkins = @ivolveindex.iv_foursquare_checkins
                @foursquare_badges_count = 0
                @foursquare_avg_badges = @ivolveindex.iv_foursquare_badges
                @foursquare_mayor_count = 0
                @foursquare_avg_mayors = @ivolveindex.iv_foursquare_mayor
                @foursquare_tips_count = 0
                @foursquare_avg_tips = @ivolveindex.iv_foursquare_tips
                @foursquare_photos_count = 0
                @foursquare_avg_photos = @ivolveindex.iv_foursquare_photos
            end
            if @foursquare_friends_count.nil?
                @foursquare_friends_count = 0
            end
            if @foursquare_following_count.nil?
                @foursquare_following_count = 0
            end
            if @foursquare_checkins_count.nil?
                @foursquare_checkins_count = 0
            end
            if @foursquare_badges_count.nil?
                @foursquare_badges_count = 0
            end
            if @foursquare_mayor_count.nil?
                @foursquare_mayor_count = 0
            end
            if @foursquare_tips_count.nil?
                @foursquare_tips_count = 0
            end
            if @foursquare_photos_count.nil?
                @foursquare_photos_count = 0
            end
            if @foursquare_avg_friends.nil?
                @foursquare_avg_friends = 0
            end
            if @foursquare_avg_following.nil?
                @foursquare_avg_following = 0
            end
            if @foursquare_avg_checkins.nil?
                @foursquare_avg_checkins = 0
            end
            if @foursquare_avg_badges.nil?
                @foursquare_avg_badges = 0
            end
            if @foursquare_avg_mayors.nil?
                @foursquare_avg_mayors = 0
            end
            if @foursquare_avg_tips.nil?
                @foursquare_avg_tips = 0
            end
            if @foursquare_avg_photos.nil?
                @foursquare_avg_photos = 0
            end

            if fitbit?
                @fitbit_height_int = @fitbit_auth_user.height_int
                @fitbit_weight_int = @fitbit_auth_user.weight_int
                @fitbit_stride_length_run_int = @fitbit_auth_user.stride_length_run_int
                @fitbit_stride_length_walk_int = @fitbit_auth_user.stride_length_walk_int
                @fitbit_lifetime_tot_active_score_int = @fitbit_auth_user.lifetime_tot_active_score_int
                @fitbit_best_tot_active_score_int = @fitbit_auth_user.best_tot_active_score_int
                @fitbit_lifetime_tot_cal_out_int = @fitbit_auth_user.lifetime_tot_cal_out_int
                @fitbit_best_tot_cal_out_int = @fitbit_auth_user.best_tot_cal_out_int
                @fitbit_lifetime_tot_dist_int = @fitbit_auth_user.lifetime_tot_dist_int
                @fitbit_best_tot_dist_int = @fitbit_auth_user.best_tot_dist_int
                @fitbit_lifetime_tot_steps_int = @fitbit_auth_user.lifetime_tot_steps_int
                @fitbit_best_tot_steps_int = @fitbit_auth_user.best_tot_steps_int
                @fitbit_avg_height = @ivolveindex.iv_fitbit_height
                @fitbit_avg_weight = @ivolveindex.iv_fitbit_weight
                @fitbit_avg_length_run = @ivolveindex.iv_fitbit_stride_length_run
                @fitbit_avg_length_walk = @ivolveindex.iv_fitbit_stride_length_walk
                @fitbit_avg_life_active_score = @ivolveindex.iv_fitbit_life_tot_active_score
                @fitbit_avg_best_active_score = @ivolveindex.iv_fitbit_best_tot_active_score
                @fitbit_avg_life_cal_out = @ivolveindex.iv_fitbit_life_tot_cal_out
                @fitbit_avg_best_cal_out = @ivolveindex.iv_fitbit_best_tot_cal_out
                @fitbit_avg_life_tot_dist = @ivolveindex.iv_fitbit_life_tot_dist
                @fitbit_avg_best_dist = @ivolveindex.iv_fitbit_best_tot_dist
                @fitbit_avg_life_tot_steps = @ivolveindex.iv_fitbit_life_tot_steps
                @fitbit_avg_best_tot_steps = @ivolveindex.iv_fitbit_best_tot_steps
            else
                @fitbit_height_int = 0
                @fitbit_avg_height = @ivolveindex.iv_fitbit_height
                @fitbit_weight_int = 0
                @fitbit_avg_weight = @ivolveindex.iv_fitbit_weight
                @fitbit_stride_length_run_int = 0
                @fitbit_avg_length_run = @ivolveindex.iv_fitbit_stride_length_run
                @fitbit_stride_length_walk_int = 0
                @fitbit_avg_length_walk = @ivolveindex.iv_fitbit_stride_length_walk
                @fitbit_lifetime_tot_active_score_int = 0
                @fitbit_avg_life_active_score = @ivolveindex.iv_fitbit_life_tot_active_score
                @fitbit_best_tot_active_score_int = 0
                @fitbit_avg_best_active_score = @ivolveindex.iv_fitbit_best_tot_active_score
                @fitbit_lifetime_tot_cal_out_int = 0
                @fitbit_avg_life_cal_out = @ivolveindex.iv_fitbit_life_tot_cal_out
                @fitbit_best_tot_cal_out_int = 0
                @fitbit_avg_best_cal_out = @ivolveindex.iv_fitbit_best_tot_cal_out
                @fitbit_lifetime_tot_dist_int = 0
                @fitbit_avg_life_tot_dist = @ivolveindex.iv_fitbit_life_tot_dist
                @fitbit_best_tot_dist_int = 0
                @fitbit_avg_best_dist = @ivolveindex.iv_fitbit_best_tot_dist
                @fitbit_lifetime_tot_steps_int = 0
                @fitbit_avg_life_tot_steps = @ivolveindex.iv_fitbit_life_tot_steps
                @fitbit_best_tot_steps_int = 0
                @fitbit_avg_best_tot_steps = @ivolveindex.iv_fitbit_best_tot_steps
            end
            if @fitbit_height_int.nil?
                @fitbit_height_int = 0
            end
            if @fitbit_weight_int.nil?
                @fitbit_weight_int = 0
            end
            if @fitbit_stride_length_run_int.nil?
                @fitbit_stride_length_run_int = 0
            end
            if @fitbit_stride_length_walk_int.nil?
                @fitbit_stride_length_walk_int = 0
            end
            if @fitbit_avg_height.nil?
                @fitbit_avg_height = 0
            end
            if @fitbit_avg_weight.nil?
                @fitbit_avg_weight = 0
            end
            if @fitbit_avg_length_run.nil?
                @fitbit_avg_length_run = 0
            end
            if @fitbit_avg_length_walk.nil?
                @fitbit_avg_length_walk = 0
            end
        end
    end


    # => stats_compare is invoked when viewing a separate user's profile, not the user's own.
    # => stats_compare compares the user to the user whose profile he is viewing.
    # => see users_controller.rb show action for usage.
    def stats_compare 
        if signed_in?
            if linkedin?
                @linkedin_int_connections = @linkedin_auth_user.connections_size
                @linkedin_int_group_memberships = @linkedin_auth_user.group_memberships_size
                @linkedin_int_job_suggestions = @linkedin_auth_user.job_suggestions_size
                @linkedin_int_job_bookmarks = @linkedin_auth_user.job_bookmarks_size
                @linkedin_int_shares = @linkedin_auth_user.shares_size
            else
                @linkedin_int_connections = 0
                @linkedin_int_group_memberships = 0
                @linkedin_int_job_suggestions = 0
                @linkedin_int_job_bookmarks = 0
                @linkedin_int_shares = 0
            end
            @other_linkedin = Authorization.find_by_user_id_and_provider(@user.id, 'linkedin')
            if !@other_linkedin.nil?
                @linkedin_other_user = LinkedinUser.find_by_uid(@other_linkedin.uid)
                if !@linkedin_other_user.nil?
                    @linkedin_avg_connections = @linkedin_other_user.connections_size
                    @linkedin_avg_group_memberships = @linkedin_other_user.group_memberships_size
                    @linkedin_avg_job_suggestions = @linkedin_other_user.job_suggestions_size
                    @linkedin_avg_job_bookmarks = @linkedin_other_user.job_bookmarks_size
                    @linkedin_avg_shares = @linkedin_other_user.shares_size
                else
                    @linkedin_avg_connections = 0
                    @linkedin_avg_group_memberships = 0
                    @linkedin_avg_job_suggestions = 0
                    @linkedin_avg_job_bookmarks = 0
                    @linkedin_avg_shares = 0
                end
            else
                @linkedin_avg_connections = 0
                @linkedin_avg_group_memberships = 0
                @linkedin_avg_job_suggestions = 0
                @linkedin_avg_job_bookmarks = 0
                @linkedin_avg_shares = 0
            end

            if @linkedin_int_connections.nil?
                @linkedin_int_connections = 0
            end
            if @linkedin_int_group_memberships.nil?
                @linkedin_int_group_memberships = 0
            end
            if @linkedin_int_job_suggestions.nil?
                @linkedin_int_job_suggestions = 0
            end
            if @linkedin_int_job_bookmarks.nil?
                @linkedin_int_job_bookmarks = 0
            end
            if @linkedin_int_shares.nil?
                @linkedin_int_shares = 0
            end
            if @linkedin_avg_connections.nil?
                @linkedin_avg_connections = 0
            end
            if @linkedin_avg_group_memberships.nil?
                @linkedin_avg_group_memberships = 0
            end
            if @linkedin_avg_job_suggestions.nil?
                @linkedin_avg_job_suggestions = 0
            end
            if @linkedin_avg_job_bookmarks.nil?
                @linkedin_avg_job_bookmarks = 0
            end
            if @linkedin_avg_shares.nil?
                @linkedin_avg_shares = 0
            end

            if twitter?   # is current_user an authorized twitter user with data saved?
                @twitter_int_friends = @twitter_auth_user.friends_int_count
                @twitter_int_followers = @twitter_auth_user.followers_int_count
                @twitter_int_sent = @twitter_auth_user.tweet_int_count
                @twitter_int_favorites = @twitter_auth_user.favorite_int_count
                @twitter_int_lists = @twitter_auth_user.listed_int_count
                @twitter_num_retweets_of_me = @twitter_auth_user.num_retweets_of_me
                @twitter_num_mentions_of_me = @twitter_auth_user.num_mentions_of_me
                @twitter_num_retweets_by_me = @twitter_auth_user.num_retweets_by_me
            else
                @twitter_int_friends = 0
                @twitter_int_followers = 0
                @twitter_int_sent = 0
                @twitter_int_favorites = 0
                @twitter_int_lists = 0
                @twitter_num_retweets_of_me = 0
                @twitter_num_mentions_of_me = 0
                @twitter_num_retweets_by_me = 0
            end
            @other_twitter = Authorization.find_by_user_id_and_provider(@user.id, 'twitter')
            if !@other_twitter.nil?
                @twitter_other_user = TwitterUser.find_by_uid(@other_twitter.uid)
                if !@twitter_other_user.nil?
                    @twitter_avg_friends = @twitter_other_user.friends_int_count
                    @twitter_avg_followers = @twitter_other_user.followers_int_count
                    @twitter_avg_sent = @twitter_other_user.tweet_int_count
                    @twitter_avg_fav = @twitter_other_user.favorite_int_count
                    @twitter_avg_lists = @twitter_other_user.listed_int_count
                    @twitter_avg_retweets_of_me = @twitter_other_user.num_retweets_of_me
                    @twitter_avg_mentions_of_me = @twitter_other_user.num_mentions_of_me
                    @twitter_avg_retweets_by_me = @twitter_other_user.num_retweets_by_me
                else
                    @twitter_avg_friends = 0
                    @twitter_avg_followers = 0
                    @twitter_avg_sent = 0
                    @twitter_avg_fav = 0
                    @twitter_avg_lists = 0
                    @twitter_avg_retweets_of_me = 0
                    @twitter_avg_mentions_of_me = 0
                    @twitter_avg_retweets_by_me = 0
                end
            else
                @twitter_avg_friends = 0
                @twitter_avg_followers = 0
                @twitter_avg_sent = 0
                @twitter_avg_fav = 0
                @twitter_avg_lists = 0
                @twitter_avg_retweets_of_me = 0
                @twitter_avg_mentions_of_me = 0
                @twitter_avg_retweets_by_me = 0
            end

            if @twitter_int_friends.nil?
                @twitter_int_friends = 0
            end
            if @twitter_int_followers.nil?
                @twitter_int_followers = 0
            end
            if @twitter_int_sent.nil?
                @twitter_int_sent = 0
            end
            if @twitter_int_favorites.nil?
                @twitter_int_favorites = 0
            end
            if @twitter_int_lists.nil?
                @twitter_int_lists = 0
            end
            if @twitter_num_retweets_of_me.nil?
                @twitter_num_retweets_of_me = 0
            end
            if @twitter_num_mentions_of_me.nil?
                @twitter_num_mentions_of_me = 0
            end
            if @twitter_num_retweets_by_me.nil?
                @twitter_num_retweets_by_me = 0
            end
            if @twitter_avg_friends.nil?
                @twitter_avg_friends = 0
            end
            if @twitter_avg_followers.nil?
                @twitter_avg_followers = 0
            end
            if @twitter_avg_sent.nil?
                @twitter_avg_sent = 0
            end
            if @twitter_avg_fav.nil?
                @twitter_avg_fav = 0
            end
            if @twitter_avg_lists.nil?
                @twitter_avg_lists = 0
            end
            if @twitter_avg_retweets_of_me.nil?
                @twitter_avg_retweets_of_me = 0
            end
            if @twitter_avg_mentions_of_me.nil?
                @twitter_avg_mentions_of_me = 0
            end
            if @twitter_avg_retweets_by_me.nil?
                @twitter_avg_retweets_by_me = 0
            end
    
            if facebook? # is current_user an authorized facebook user with data saved?
                @facebook_int_friends = @facebook_auth_user.int_friends
                @facebook_int_likes = @facebook_auth_user.int_likes
                @facebook_int_posts = @facebook_auth_user.int_posts
                @facebook_int_statuses = @facebook_auth_user.int_statuses
                @facebook_int_achievements = @facebook_auth_user.int_achievements
                @facebook_int_subscribers = @facebook_auth_user.int_subscribers
                @facebook_int_subscribed_to = @facebook_auth_user.int_subscribed_to
            else
                @facebook_int_friends = 0
                @facebook_int_likes = 0
                @facebook_int_posts = 0
                @facebook_int_statuses = 0
                @facebook_int_achievements = 0
                @facebook_int_subscribers = 0
                @facebook_int_subscribed_to = 0
            end
            @other_facebook = Authorization.find_by_user_id_and_provider(@user.id, 'facebook')
            if !@other_facebook.nil?
                @facebook_other_user = FacebookUser.find_by_uid(@other_facebook.uid)
                if !@facebook_other_user.nil?
                    @facebook_avg_friends = @facebook_other_user.int_friends
                    @facebook_avg_likes = @facebook_other_user.int_likes
                    @facebook_avg_posts = @facebook_other_user.int_posts
                    @facebook_avg_statuses = @facebook_other_user.int_statuses
                    @facebook_avg_achievements = @facebook_other_user.int_achievements
                    @facebook_avg_subscribers = @facebook_other_user.int_subscribers
                    @facebook_avg_subscribed_to = @facebook_other_user.int_subscribed_to
                else
                    @facebook_avg_friends = 0
                    @facebook_avg_likes = 0
                    @facebook_avg_posts = 0
                    @facebook_avg_statuses = 0
                    @facebook_avg_achievements = 0
                    @facebook_avg_subscribers = 0
                    @facebook_avg_subscribed_to = 0
                end
            else
                @facebook_avg_friends = 0
                @facebook_avg_likes = 0
                @facebook_avg_posts = 0
                @facebook_avg_statuses = 0
                @facebook_avg_achievements = 0
                @facebook_avg_subscribers = 0
                @facebook_avg_subscribed_to = 0
            end

            if @facebook_int_friends.nil?
                @facebook_int_friends = 0
            end
            if @facebook_int_likes.nil?
                @facebook_int_likes = 0
            end
            if @facebook_int_posts.nil?
                @facebook_int_posts = 0
            end
            if @facebook_int_statuses.nil?
                @facebook_int_statuses = 0
            end
            if @facebook_int_achievements.nil?
                @facebook_int_achievements = 0
            end
            if @facebook_int_subscribers.nil?
                @facebook_int_subscribers = 0
            end
            if @facebook_int_subscribed_to.nil?
                @facebook_int_subscribed_to = 0
            end
            if @facebook_avg_friends.nil?
                @facebook_avg_friends = 0
            end
            if @facebook_avg_likes.nil?
                @facebook_avg_likes = 0
            end
            if @facebook_avg_posts.nil?
                @facebook_avg_posts = 0
            end
            if @facebook_avg_statuses.nil?
                @facebook_avg_statuses = 0
            end
            if @facebook_avg_achievements.nil?
                @facebook_avg_achievements = 0
            end
            if @facebook_avg_subscribers.nil?
                @facebook_avg_subscribers = 0
            end
            if @facebook_avg_subscribed_to.nil?
                @facebook_avg_subscribed_to = 0
            end
            
            if instagram?
                @instagram_int_followers = @instagram_auth_user.int_followers
                @instagram_int_following = @instagram_auth_user.int_following
                @instagram_int_media = @instagram_auth_user.int_media
                @instagram_int_likes_out = @instagram_auth_user.int_likes_out
            else
                @instagram_int_followers = 0
                @instagram_int_following = 0
                @instagram_int_media = 0
                @instagram_int_likes_out = 0
            end
            @other_instagram = Authorization.find_by_user_id_and_provider(@user.id, 'instagram')
            if !@other_instagram.nil?
                @instagram_other_user = InstagramUser.find_by_uid(@other_instagram.uid)
                if !@instagram_other_user.nil?
                    @instagram_avg_followers = @instagram_other_user.int_followers
                    @instagram_avg_following = @instagram_other_user.int_following
                    @instagram_avg_media = @instagram_other_user.int_media
                    @instagram_avg_likes_out = @instagram_other_user.int_likes_out
                else
                    @instagram_avg_followers = 0
                    @instagram_avg_following = 0
                    @instagram_avg_media = 0
                    @instagram_avg_likes_out = 0
                end
            else
                @instagram_avg_followers = 0
                @instagram_avg_following = 0
                @instagram_avg_media = 0
                @instagram_avg_likes_out = 0
            end

            if @instagram_int_followers.nil?
                @instagram_int_followers = 0
            end
            if @instagram_int_following.nil?
                @instagram_int_following = 0
            end
            if @instagram_int_media.nil?
                @instagram_int_media = 0
            end
            if @instagram_int_likes_out.nil?
                @instagram_int_likes_out = 0
            end
            if @instagram_avg_followers.nil?
                @instagram_avg_followers = 0
            end
            if @instagram_avg_following.nil?
                @instagram_avg_following = 0
            end
            if @instagram_avg_media.nil?
                @instagram_avg_media = 0
            end
            if @instagram_avg_likes_out.nil?
                @instagram_avg_likes_out = 0
            end

            if foursquare?
                @foursquare_friends_count = @foursquare_auth_user.friends_count
                @foursquare_following_count = @foursquare_auth_user.following_count
                @foursquare_checkins_count = @foursquare_auth_user.checkins_count
                @foursquare_badges_count = @foursquare_auth_user.badges_count
                @foursquare_mayor_count = @foursquare_auth_user.mayor_count
                @foursquare_tips_count = @foursquare_auth_user.tips_count
                @foursquare_photos_count = @foursquare_auth_user.photos_count
            else
                @foursquare_friends_count = 0
                @foursquare_following_count = 0
                @foursquare_checkins_count = 0
                @foursquare_badges_count = 0
                @foursquare_mayor_count = 0
                @foursquare_tips_count = 0
                @foursquare_photos_count = 0
            end
            @other_foursquare = Authorization.find_by_user_id_and_provider(@user.id, 'foursquare')
            if !@other_foursquare.nil?
                @foursquare_other_user = FoursquareUser.find_by_uid(@other_foursquare.uid)
                if !@foursquare_other_user.nil?
                    @foursquare_avg_friends = @foursquare_other_user.friends_count
                    @foursquare_avg_following = @foursquare_other_user.following_count
                    @foursquare_avg_checkins = @foursquare_other_user.checkins_count
                    @foursquare_avg_badges = @foursquare_other_user.badges_count
                    @foursquare_avg_mayors = @foursquare_other_user.mayor_count
                    @foursquare_avg_tips = @foursquare_other_user.tips_count
                    @foursquare_avg_photos = @foursquare_other_user.photos_count
                else
                    @foursquare_avg_friends = 0
                    @foursquare_avg_following = 0
                    @foursquare_avg_checkins = 0
                    @foursquare_avg_badges = 0
                    @foursquare_avg_mayors = 0
                    @foursquare_avg_tips = 0
                    @foursquare_avg_photos = 0
                end
            else
                @foursquare_avg_friends = 0
                @foursquare_avg_following = 0
                @foursquare_avg_checkins = 0
                @foursquare_avg_badges = 0
                @foursquare_avg_mayors = 0
                @foursquare_avg_tips = 0
                @foursquare_avg_photos = 0
            end

            if @foursquare_friends_count.nil?
                @foursquare_friends_count = 0
            end
            if @foursquare_following_count.nil?
                @foursquare_following_count = 0
            end
            if @foursquare_checkins_count.nil?
                @foursquare_checkins_count = 0
            end
            if @foursquare_badges_count.nil?
                @foursquare_badges_count = 0
            end
            if @foursquare_mayor_count.nil?
                @foursquare_mayor_count = 0
            end
            if @foursquare_tips_count.nil?
                @foursquare_tips_count = 0
            end
            if @foursquare_photos_count.nil?
                @foursquare_photos_count = 0
            end
            if @foursquare_avg_friends.nil?
                @foursquare_avg_friends = 0
            end
            if @foursquare_avg_following.nil?
                @foursquare_avg_following = 0
            end
            if @foursquare_avg_checkins.nil?
                @foursquare_avg_checkins = 0
            end
            if @foursquare_avg_badges.nil?
                @foursquare_avg_badges = 0
            end
            if @foursquare_avg_mayors.nil?
                @foursquare_avg_mayors = 0
            end
            if @foursquare_avg_tips.nil?
                @foursquare_avg_tips = 0
            end
            if @foursquare_avg_photos.nil?
                @foursquare_avg_photos = 0
            end
            
            if fitbit?
                @fitbit_height_int = @fitbit_auth_user.height_int
                @fitbit_weight_int = @fitbit_auth_user.weight_int
                @fitbit_stride_length_run_int = @fitbit_auth_user.stride_length_run_int
                @fitbit_stride_length_walk_int = @fitbit_auth_user.stride_length_walk_int
                @fitbit_lifetime_tot_active_score_int = @fitbit_auth_user.lifetime_tot_active_score_int
                @fitbit_best_tot_active_score_int = @fitbit_auth_user.best_tot_active_score_int
                @fitbit_lifetime_tot_cal_out_int = @fitbit_auth_user.lifetime_tot_cal_out_int
                @fitbit_best_tot_cal_out_int = @fitbit_auth_user.best_tot_cal_out_int
                @fitbit_lifetime_tot_dist_int = @fitbit_auth_user.lifetime_tot_dist_int
                @fitbit_best_tot_dist_int = @fitbit_auth_user.best_tot_dist_int
                @fitbit_lifetime_tot_steps_int = @fitbit_auth_user.lifetime_tot_steps_int
                @fitbit_best_tot_steps_int = @fitbit_auth_user.best_tot_steps_int
            else
                @fitbit_height_int = 0
                @fitbit_weight_int = 0
                @fitbit_stride_length_run_int = 0
                @fitbit_stride_length_walk_int = 0
                @fitbit_lifetime_tot_active_score_int = 0
                @fitbit_best_tot_active_score_int = 0
                @fitbit_best_tot_active_date = 0
                @fitbit_lifetime_tot_cal_out_int = 0
                @fitbit_best_tot_cal_out_int = 0
                @fitbit_best_tot_cal_out_date = 0
                @fitbit_lifetime_tot_dist_int = 0
                @fitbit_best_tot_dist_int = 0
                @fitbit_best_tot_dist_date = 0
                @fitbit_lifetime_tot_steps_int = 0
                @fitbit_best_tot_steps_int = 0
                @fitbit_best_tot_steps_date = 0
            end
            @other_fitbit = Authorization.find_by_user_id_and_provider(@user.id, 'fitbit')
            if !@other_fitbit.nil?
                @fitbit_other_user = FitbitUser.find_by_encoded_id(@other_fitbit.uid)
                if !@fitbit_other_user.nil?
                    @fitbit_avg_height = @fitbit_other_user.height_int
                    @fitbit_avg_weight = @fitbit_other_user.weight_int
                    @fitbit_avg_length_run = @fitbit_other_user.stride_length_run_int
                    @fitbit_avg_length_walk = @fitbit_other_user.stride_length_walk_int
                    @fitbit_avg_life_active_score = @fitbit_other_user.lifetime_tot_active_score_int
                    @fitbit_avg_best_active_score = @fitbit_other_user.best_tot_active_score_int
                    @fitbit_avg_life_cal_out = @fitbit_other_user.lifetime_tot_cal_out_int
                    @fitbit_avg_best_cal_out = @fitbit_other_user.best_tot_cal_out_int
                    @fitbit_avg_life_tot_dist = @fitbit_other_user.lifetime_tot_dist_int
                    @fitbit_avg_best_dist = @fitbit_other_user.best_tot_dist_int
                    @fitbit_avg_life_tot_steps = @fitbit_other_user.lifetime_tot_steps_int
                    @fitbit_avg_best_tot_steps = @fitbit_other_user.best_tot_steps_int
                else
                    @fitbit_avg_height = 0
                    @fitbit_avg_weight = 0
                    @fitbit_avg_length_run = 0
                    @fitbit_avg_length_walk = 0
                    @fitbit_avg_life_active_score = 0
                    @fitbit_avg_best_active_score = 0
                    @fitbit_avg_life_cal_out = 0
                    @fitbit_avg_best_cal_out = 0
                    @fitbit_avg_life_tot_dist = 0
                    @fitbit_avg_best_dist = 0
                    @fitbit_avg_life_tot_steps = 0
                    @fitbit_avg_best_tot_steps = 0
                end
            else
                @fitbit_avg_height = 0
                @fitbit_avg_weight = 0
                @fitbit_avg_length_run = 0
                @fitbit_avg_length_walk = 0
                @fitbit_avg_life_active_score = 0
                @fitbit_avg_best_active_score = 0
                @fitbit_avg_life_cal_out = 0
                @fitbit_avg_best_cal_out = 0
                @fitbit_avg_life_tot_dist = 0
                @fitbit_avg_best_dist = 0
                @fitbit_avg_life_tot_steps = 0
                @fitbit_avg_best_tot_steps = 0
            end

            if @fitbit_height_int.nil?
                @fitbit_height_int = 0
            end
            if @fitbit_weight_int.nil?
                @fitbit_weight_int = 0
            end
            if @fitbit_stride_length_run_int.nil?
                @fitbit_stride_length_run_int = 0
            end
            if @fitbit_stride_length_walk_int.nil?
                @fitbit_stride_length_walk_int = 0
            end
            if @fitbit_avg_height.nil?
                @fitbit_avg_height = 0
            end
            if @fitbit_avg_weight.nil?
                @fitbit_avg_weight = 0
            end
            if @fitbit_avg_length_run.nil?
                @fitbit_avg_length_run = 0
            end
            if @fitbit_avg_length_walk.nil?
                @fitbit_avg_length_walk = 0
            end
        end
    end
end