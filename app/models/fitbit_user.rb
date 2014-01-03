class FitbitUser < ActiveRecord::Base
	belongs_to :user
	# the default scope below will always find the newest record first
	default_scope -> { order('created_at DESC') }
	after_validation :report_validation_errors_to_rollbar

	def self.wellness_bar_by_date(start)
		data = where(created_at: start.beginning_of_day..Time.zone.now)
		data = data.group("date(created_at)")
		data = data.select("date(created_at) as created_at, sum(height_int + weight_int + stride_length_run_int + stride_length_walk_int) as physical")
		data.group_by { |d| d.created_at.to_date }
	end

	def self.pull_user_data(user)
		fitbit_auth = Authorization.find_by_user_id_and_provider(user, 'fitbit')
		my_key = "cfe66ba8f21941c292ff4a21b075cac3"
		my_secret = "9117581161064da9bfe8b36b2b79b689"
		user_token = fitbit_auth.oauth_token
		user_secret = fitbit_auth.oauth_secret
		client = Fitgem::Client.new(
			:consumer_key => my_key,
			:consumer_secret => my_secret,
			:token => user_token,
			:secret => user_secret,
		)
		user_id = fitbit_auth.user_id
		user_hash = client.user_info['user']
			if !user_hash['avatar'].nil?
				@avatar = user_hash['avatar']
			end
			if !user_hash['avatar150'].nil?
				@avatar_onefifty = user_hash['avatar150']
			end
				#@user_city = 
			if !user_hash['country'].nil?
				@user_country = user_hash['country']
			end
			if !user_hash['dateOfBirth'].nil?
				@date_of_birth = user_hash['dateOfBirth']
			end
			if !user_hash['displayName'].nil?
				@display_name = user_hash['displayName']
			end
			if !user_hash['distanceUnit'].nil?
				@distance_unit = user_hash['distanceUnit']
			end
			if !user_hash['encodedId'].nil?
				@encoded_id = user_hash['encodedId']
			end
				#@full_name = 
			if !user_hash['gender'].nil?
				@gender = user_hash['gender']
			end
			if !user_hash['glucoseUnit'].nil?
				@glucose_unit = user_hash['glucoseUnit']
			end
			if !user_hash['height'].nil?
				@height = user_hash['height']
			end
			if !user_hash['heightUnit'].nil?
				@height_unit = user_hash['heightUnit']
			end
				#@nickname = 
			if !user_hash['locale'].nil?
				@locale = user_hash['locale']
			end
			if !user_hash['memberSince'].nil?
				@member_since = user_hash['memberSince']
			end
			if !user_hash['offsetFromUTCMillis'].nil?
				@utc_offset = user_hash['offsetFromUTCMillis']
			end
				#@home_state = 
			if !user_hash['strideLengthRunning'].nil?
				@stride_length_run = user_hash['strideLengthRunning']
			end
			if !user_hash['strideLengthWalking'].nil?
				@stride_length_walk = user_hash['strideLengthWalking']
			end
			if !user_hash['timezone'].nil?
				@timezone = user_hash['timezone']
			end
			if !user_hash['waterUnit'].nil?
				@water_unit = user_hash['waterUnit']
			end
			if !user_hash['weight'].nil?
				@weight = user_hash['weight']
			end
			if !user_hash['weightUnit'].nil?
				@weight_unit = user_hash['weightUnit']
			end
		if !client.activity_statistics.nil?
			act_stat = client.activity_statistics
			if !act_stat['best'].nil?
				if !act_stat['best']['total'].nil?
					if !act_stat['best']['total']['activeScore'].nil?
						if !act_stat['best']['total']['activeScore']['date'].nil?
							@best_tot_active_score_date = act_stat['best']['total']['activeScore']['date']
						end
						if !act_stat['best']['total']['activeScore']['value'].nil?
							@best_tot_active_score_value = act_stat['best']['total']['activeScore']['value']
						end
					end
					if !act_stat['best']['total']['caloriesOut'].nil?
						if !act_stat['best']['total']['caloriesOut']['date'].nil?
							@best_tot_cal_out_date= act_stat['best']['total']['caloriesOut']['date']
						end
						if !act_stat['best']['total']['caloriesOut']['value'].nil?
							@best_tot_cal_out_value= act_stat['best']['total']['caloriesOut']['value']
						end
					end
					if !act_stat['best']['total']['distance'].nil?
						if !act_stat['best']['total']['distance']['date'].nil?
							@best_tot_dist_date= act_stat['best']['total']['distance']['date']
						end
						if !act_stat['best']['total']['distance']['value'].nil?
							@best_tot_dist_value= act_stat['best']['total']['distance']['value']
						end
					end
					if !act_stat['best']['total']['steps'].nil?
						if !act_stat['best']['total']['steps']['date'].nil?
							@best_tot_steps_date= act_stat['best']['total']['steps']['date']
						end
						if !act_stat['best']['total']['steps']['value'].nil?
							@best_tot_steps_value= act_stat['best']['total']['steps']['value']
						end
					end
				end
				if !act_stat['best']['tracker'].nil?
					if !act_stat['best']['tracker']['caloriesOut'].nil?
						if !act_stat['best']['tracker']['caloriesOut']['date'].nil?
							@best_track_cal_out_date= act_stat['best']['tracker']['caloriesOut']['date']
						end
						if !act_stat['best']['tracker']['caloriesOut']['value'].nil?
							@best_track_cal_out_value= act_stat['best']['tracker']['caloriesOut']['value']
						end
					end
				end
			end
			if !act_stat['lifetime'].nil?
				if !act_stat['lifetime']['total'].nil?
					if !act_stat['lifetime']['total']['activeScore'].nil?
						@lifetime_tot_active_score= act_stat['lifetime']['total']['activeScore']
					end
					if !act_stat['lifetime']['total']['caloriesOut'].nil?
						@lifetime_tot_cal_out= act_stat['lifetime']['total']['caloriesOut']
					end
					if !act_stat['lifetime']['total']['distance'].nil?
						@lifetime_tot_dist= act_stat['lifetime']['total']['distance']
					end
					if !act_stat['lifetime']['total']['steps'].nil?
						@lifetime_tot_steps= act_stat['lifetime']['total']['steps']
					end
				end
				if !act_stat['lifetime']['tracker'].nil?
					if !act_stat['lifetime']['tracker']['activeScore'].nil?
						@lifetime_track_active_score= act_stat['lifetime']['tracker']['activeScore']
					end
					if !act_stat['lifetime']['tracker']['caloriesOut'].nil?
						@lifetime_track_cal_out= act_stat['lifetime']['tracker']['caloriesOut']
					end
					if !act_stat['lifetime']['tracker']['distance'].nil?
						@lifetime_track_dist= act_stat['lifetime']['tracker']['distance']
					end
					if !act_stat['lifetime']['tracker']['steps'].nil?
						@lifetime_track_steps= act_stat['lifetime']['tracker']['steps']
					end
				end
			end
		end
		if !client.favorite_activities.nil?
			fav_act = client.favorite_activities
			if !fav_act[0].nil?
				@fav_activity_name_one= fav_act[0]['name']
				if !fav_act[1].nil?
					@fav_activity_name_two= fav_act[1]['name']
					if !fav_act[2].nil?
						@fav_activity_name_three= fav_act[2]['name']
					end
				end
			end
		end
		if !client.frequent_activities.nil?
			freq_act = client.frequent_activities
			if !freq_act[0].nil?
				@freq_activity_name_one = freq_act[0]['name']
				if !freq_act[1].nil?
					@freq_activity_name_two = freq_act[1]['name']
					if !freq_act[2].nil?
						@freq_activity_name_three = freq_act[2]['name']
					end
				end
			end
		end
		if !client.frequent_foods.nil?
			freq_food = client.frequent_foods
			if !freq_food[0].nil?
				@freq_food_name_one = freq_food[0]['name']
				if !freq_food[1].nil?
					@freq_food_name_two = freq_food[1]['name']
					if !freq_food[2].nil?
						@freq_food_name_three = freq_food[2]['name']
					end
				end
			end
		end
		if !client.recent_activities.nil?
			rec_act = client.recent_activities
			if !rec_act[0].nil?
				@rec_activity_name_one = rec_act[0]['name']
				if !rec_act[1].nil?
					@rec_activity_name_two = rec_act[1]['name']
					if !rec_act[2].nil?
						@rec_activity_name_three = rec_act[2]['name']
					end
				end
			end
			if !rec_act[0].nil?
				@rec_activity_cal_one = rec_act[0]['calories']
				if !rec_act[1].nil?
					@rec_activity_cal_two = rec_act[1]['calories']
					if !rec_act[2].nil?
						@rec_activity_cal_three = rec_act[2]['calories']
					end
				end
			end
		end
		if !client.recent_foods.nil?
			rec_food = client.recent_foods
			if !rec_food[0].nil?
				@rec_food_name_one = rec_food[0]['name']
				if !rec_food[1].nil?
					@rec_food_name_two = rec_food[1]['name']
					if !rec_food[2].nil?
						@rec_food_name_three = rec_food[2]['name']
					end
				end
			end
		end


		create!(
			avatar: @avatar,
			avatar_onefifty: @avatar_onefifty,
			user_country: @user_country,
			date_of_birth: @date_of_birth,
			display_name: @display_name,
			distance_unit: @distance_unit,
			encoded_id: @encoded_id,
			user_id: user_id,
			gender: @gender,
			glucose_unit: @glucose_unit,
			height: @height,
			height_int: @height,
			height_unit: @height_unit,
			locale: @locale,
			member_since: @member_since,
			utc_offset: @utc_offset,
			stride_length_run: @stride_length_run,
			stride_length_run_int: @stride_length_run,
			stride_length_walk: @stride_length_walk,
			stride_length_walk_int: @stride_length_walk,
			timezone: @timezone,
			water_unit: @water_unit,
			weight: @weight,
			weight_int: @weight,
			weight_unit: @weight_unit,
			best_tot_active_score_date: @best_tot_active_score_date,
			best_tot_active_score_value: @best_tot_active_score_value,
			best_tot_active_score_int: @best_tot_active_score_value,
			best_tot_cal_out_date: @best_tot_cal_out_date,
			best_tot_cal_out_value: @best_tot_cal_out_value,
			best_tot_cal_out_int: @best_tot_cal_out_value,
			best_tot_dist_date: @best_tot_dist_date,
			best_tot_dist_value: @best_tot_dist_value,
			best_tot_dist_int: @best_tot_dist_value,
			best_tot_steps_date: @best_tot_steps_date,
			best_tot_steps_value: @best_tot_steps_value,
			best_tot_steps_int: @best_tot_steps_value,
			best_track_cal_out_date: @best_track_cal_out_date,
			best_track_cal_out_value: @best_track_cal_out_value,
			best_track_cal_out_int: @best_track_cal_out_value,
			best_track_cal_out_value: @best_track_cal_out_value,
			lifetime_tot_active_score: @lifetime_tot_active_score,
			lifetime_tot_active_score_int: @lifetime_tot_active_score,
			lifetime_tot_cal_out: @lifetime_tot_cal_out,
			lifetime_tot_cal_out_int: @lifetime_tot_cal_out,
			lifetime_tot_dist: @lifetime_tot_dist,
			lifetime_tot_dist_int: @lifetime_tot_dist,
			lifetime_tot_steps: @lifetime_tot_steps,
			lifetime_tot_steps_int: @lifetime_tot_steps,
			lifetime_track_active_score: @lifetime_track_active_score,
			lifetime_track_active_score_int: @lifetime_track_active_score,
			lifetime_track_cal_out: @lifetime_track_cal_out,
			lifetime_track_cal_out_int: @lifetime_track_cal_out,
			lifetime_track_dist: @lifetime_track_dist,
			lifetime_track_dist_int: @lifetime_track_dist,
			lifetime_track_steps: @lifetime_track_steps,
			lifetime_track_steps_int: @lifetime_track_steps,
			fav_activity_name_one: @fav_activity_name_one,
			fav_activity_name_two: @fav_activity_name_two,
			fav_activity_name_three: @fav_activity_name_three,
			freq_activity_name_one: @freq_activity_name_one,
			freq_activity_name_two: @freq_activity_name_two,
			freq_activity_name_three: @freq_activity_name_three,
			freq_food_name_one: @freq_food_name_one,
			freq_food_name_two: @freq_food_name_two, 
			freq_food_name_three: @freq_food_name_three,
			rec_activity_name_one: @rec_activity_name_one,
			rec_activity_name_two: @rec_activity_name_two,
			rec_activity_name_three: @rec_activity_name_three,
			rec_activity_cal_one: @rec_activity_cal_one,
			rec_activity_cal_two: @rec_activity_cal_two,
			rec_activity_cal_three: @rec_activity_cal_three,
			rec_food_name_one: @rec_food_name_one,
			rec_food_name_two: @rec_food_name_two,
			rec_food_name_three: @rec_food_name_three
		)
	end

	def self.sched_user_data
		# fitbit_sched could be a scope?
		fitbit_sched = Authorization.where(provider: 'fitbit') 
		# is there a better way to run the following method once we have 1000s of fitbit auths??
		fitbit_sched.each do |fitbit_sched|
			FitbitUser.pull_user_data(fitbit_sched.user)
		end
	end
end
