FactoryGirl.define do 
	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password	"foobar"
		password_confirmation	"foobar"

		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content "Lorem ipsum"
		user
	end

	factory :activity do
		achievement_id "integer"
		user
		value "12345"
		app_log_id "12345"
		time "12:45"
		description "complete activity"
	end

	factory :api do
		user
      	company "acme network"
      	company_id 12345
      	con_key	"12345"
      	con_secret "12345"
      	access_token "12345"
      	access_secret "12345"
    end
end