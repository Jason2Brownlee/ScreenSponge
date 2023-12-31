# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Email settings
#config.action_mailer.delivery_method = :test
config.action_mailer.raise_delivery_errors = false
config.action_mailer.perform_deliveries = false

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :tls => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "screensponge.com",
    :authentication => :plain,
    :user_name => "support@screensponge.com",
    :password => "mayhemmXOTmz"
}

SITE_URL = "localhost:3000"
FEEDBACK_RECIPIENT = "dev@screensponge.com"
SUPPORT_EMAIL = "support@screensponge.com"