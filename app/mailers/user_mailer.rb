class UserMailer < ActionMailer::Base
  default from: "info@ivolve.me",
  # temporary defaults for testing:
  cc: ["roane@ivolve.me", "mike@ivolve.me", "pat@ivolve.me"]

  def welcome_email(user_id)
  	@recipient = User.find_by_id(user_id)
    attachments["ivolvecaveman.jpg"] = File.read("#{Rails.root}/app/assets/images/ivolvecaveman.jpg")
  	email_with_name = "#{@recipient.name} <#{@recipient.email}"
  	@signin_url = 'https://ivolve.herokuapp.com/signin'
  	@home_url = 'https://ivolve.herokuapp.com'
  	mail(to: email_with_name, subject: 'Welcome to iVolve!')
  end
end
