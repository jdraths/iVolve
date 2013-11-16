desc "This task is called by the heroku scheduler"
task :twitter_sched => :environment do 
	puts "Twitter API..."
	TwitterUser.sched_user_data
	puts "completed twitter user, skipping fetch tweets..."
	#FetchTweet.sched_fetch_tweets
	puts "done."
end

task :facebook_sched => :environment do 
	puts "Facebook API..."
	FacebookUser.sched_user_data
	puts "done."
end

task :instagram_sched => :environment do
	puts "Instagram API..."
	InstagramUser.sched_user_data
	puts "done."
end

task :fitbit_sched => :environment do
	puts "Fitbit API..."
	FitbitUser.sched_user_data
	puts "done."
end

task :index_sched => :environment do
	puts "Calcing Index..."
	IvolveIndex.populate_data
	puts "done."
end