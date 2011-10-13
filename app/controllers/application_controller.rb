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
    # check cookie
    # refresh token
    # auth

    puts session.to_json

    if session[:oauth_access_token].nil? || session[:oauth_access_token].empty?

      redirect_to :controller => 'auth', :action => 'index'
      return
      
    else

      if !(session[:oauth_expires_at].nil?) && session[:oauth_expires_at].to_datetime < DateTime.now
        begin
          access_token = Salesforce::Authentication.refresh(
            SalesforceOAuth::Application.config.api_key,
            SalesforceOAuth::Application.config.api_secret, 
            session[:oauth_refresh_token]
          )
        rescue
          # delete cookie
          reset_session
          redirect_to :controller => 'auth', :action => 'index'
          return
        end

        # save session
        session[:oauth_access_token] = access_token.token
        session[:oauth_refresh_token] = access_token.refresh_token
        session[:oauth_expires_at] = access_token.expires_in + DateTime.now
      end

    end

  end
  
end
