# This file initializes the omniauth client to authenticate users.
# Need to put iVolve Consumer Token and Secret in Environment variables.
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, 'iA0zWYfLeg2aWA35cxi5g', 'S0GVADK1a4HGjp9QgVKydKn7YgetC0uHLtqScNa0'
  #provider :google_oauth2, 
  provider :fitbit, 'cfe66ba8f21941c292ff4a21b075cac3', '9117581161064da9bfe8b36b2b79b689'
  provider :facebook, '653457061342937', '83c0c37d58098651663ba8ce86df2df8', 
  	scope: "user_likes, user_about_me, user_birthday, user_education_history, email, user_hometown, user_relationship_details, user_location, user_religion_politics, user_relationships, user_website, user_work_history, manage_pages, user_games_activity, user_activities, user_photos, user_checkins, user_events, read_stream, read_friendlists, user_groups, user_interests, user_notes, read_mailbox, user_questions, user_videos",
  	display: 'popup',
  	auth_type: 'reauthenticate'
  provider :identity, fields: [:email, :name], model: User, on_failed_registration: lambda { |env|
  	UsersController.action(:new).call(env)
  }

  OmniAuth.config.logger = Rails.logger
end