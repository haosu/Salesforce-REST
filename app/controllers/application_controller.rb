require 'oauth2'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def client
    OAuth2::Client.new(
      SalesforceOAuth::Application.config.api_key, 
      SalesforceOAuth::Application.config.api_secret, 
      :site => SalesforceOAuth::Application.config.rest_site,
      :authorize_url => SalesforceOAuth::Application.config.authorize_path,
      :token_url => SalesforceOAuth::Application.config.access_token_path
    )
  end

  def authenticate
    redirect_to :controller => 'auth', :action => 'index'

    #redirect_to "auth#index"
    # check if authenticated
    # authenticated ?
    #   continue
    # else
    #   go to authentication url
  end
  
end
