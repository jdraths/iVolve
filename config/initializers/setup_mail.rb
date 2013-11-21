ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'ivolve.me',
  user_name:            'info@ivolve.me',
  password:             'MJRD!r4rent',
  authentication:       'plain',
  enable_starttls_auto: true  }

ActionMailer::Base.default_url_options[:host] = 'localhost:3000'