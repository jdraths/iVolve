module UserActivityHelper
	@@database = SiteVisit.all

	def tot_url
		url_hash = Hash.new(0)
		@@database.each do |entry|
			url_hash[entry[:url]] += 1
		end
		url_hash
	end

	def url_count
		@home_page = tot_url["https://www.ivolve.herokuapp.com"]
		@users_page = tot_url["https://www.ivolve.herokuapp.com/users"]
		@user_page = tot_url["https://www.ivolve.herokuapp.com/users/1"]
		@about_page = tot_url["https://www.ivolve.herokuapp.com/about"]
		@help_page = tot_url["https://www.ivolve.herokuapp.com/help"]
		@contact_page = tot_url["https://www.ivolve.herokuapp.com/contact"]
		
	end



	def sum_action(act)
		@act_total = 0
		database.each do |entry|
			entry[:action].include?(act)
			@act_total += 1
		end
	end
end