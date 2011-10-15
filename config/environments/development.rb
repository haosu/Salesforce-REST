SalesforceOAuth::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true


  config.rest_url         = /prerelna[0-9]*/
  config.soap_url         = '.salesforce.com/services/Soap/c/22.0/'
  config.instance_version = '/services/data/v22.0/'


  config.logout_endpoint = '/secur/logout.jsp'

  config.redirect_uri = 'http://localhost:3000/auth/callback'
  config.rest_site    = 'https://login.salesforce.com'
  config.refresh_site = 'https://login.salesforce.com/services/oauth2/token'

  config.authorize_path = '/services/oauth2/authorize'
  config.access_token_path = '/services/oauth2/token'

  config.api_key = '3MVG9QDx8IX8nP5THIHNlvKTP7uY47MlR.y2H6AU0D1p5GKz3y9M2ZgJARLaO8Ff9j5lXo1h4ek3dEGB3ZFLV'
  config.api_secret = '2918614414129053017'

  #config.compass_css_dir = 'public/stylesheets'
end
