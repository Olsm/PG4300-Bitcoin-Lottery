# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# show delivery errors
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
    :address        => 'cpanel.immortaltools.com',
    :domain         => 'ghost.mxroute.com',
    :ssl            => true,
    :port           => '465',
    :user_name      => 'bitcoinlottery@immortaltools.com',
    :password       => 'SuchV3ryL0ttery',
    :authentication => :plain,
    :enable_starttls_auto => true
}