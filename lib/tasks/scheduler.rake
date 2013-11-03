desc "This task is called by the heroku scheduler"
task :twitter_sched => :environment do 
	puts "Twitter API..."
	TwitterUser.sched_user_data
	puts "completed twitter user, now to fetch tweets..."
	FetchTweets.sched_fetch_tweets
	puts "done."
end

task :facebook_sched => :environment do 
	puts "Facebook API..."
	FacebookUser.sched_user_data
	puts "done."
end