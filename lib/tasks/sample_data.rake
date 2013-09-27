namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
		make_activities
		make_apis
	end
end

def make_users
	admin = User.create!(name: 		"Example User",
						 email: 	"example@railstutorial.org",
						 password:  "foobar",
						 password_confirmation: "foobar",
						 admin: true)
	99.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(name: name,
					email: email,
					password: password,
					password_confirmation: password)
	end
end

def make_microposts
	users = User.all(limit: 6)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers 	   = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each 		{ |follower| follower.follow!(user) }
end

def make_activities
	users = User.all(limit: 6)
	50.times do |n|
		achievement = n
		value = "+10 Ph! "
		app_log = n
		time = n
		description = "Ran 3 miles on Fitbit!"
		users.each do |user| 
			user.activities.create!(achievement_id: achievement, 
				value: value,
				app_log_id: app_log, 
				time: time, 
				description: description)

		end
	end
end

def make_apis
	users = User.all(limit: 6)
	50.times do |n|
      	company = Faker::Company.name
      	company_id = "12345"
      	con_key = "12345"
      	con_secret = "12345"
      	access_token = "12345"
      	access_secret = "12345"
      	users.each do |user|
      		user.apis.create!(company: company,
      			company_id: company_id,
      			con_key: con_key,
      			con_secret: con_secret,
      			access_token: access_token,
      			access_secret: access_secret)
      	end
    end
end
