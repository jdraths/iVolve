module UserActvityHelper
	database = SiteVisit.all
	def sum_url(url_link)
		total = 0
		database.each do |entry|
			entry[:url] == url_link ? total += 1 : total = 0
		end
	end

	def sum_action(act)
		total = 0
		database.each do |entry|
			entry[:action].include?(act)
			total += 1
		end
	end
end