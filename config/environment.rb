# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# show delivery errors
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
    :user_name => 'bitcoinlottery',
    :password => 'Sdcz4zn4dALN3mV0KPPVJQ0VA6Gy0n3Ia270iK7c7gntKsP2UQ6HDchkBr9iLSCosPSjdIvhwJazKBYaHc31H9zgP5McYvpS3xFO',
    :domain => 'immortaltools.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}