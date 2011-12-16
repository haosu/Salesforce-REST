require 'oauth2'
require 'salesforce'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    # check cookie
    # refresh token
    # auth
    if session[:oauth_access_token].nil? || session[:oauth_access_token].empty?

      redirect_to :controller => 'auth', :action => 'index'
      return

    else

      if !(session[:oauth_expires_at].nil?) && session[:oauth_expires_at].to_datetime < DateTime.now
        begin
          redirect_to :controller => 'auth', :action => 'refresh'
          return
        rescue
          # delete cookie
          reset_session
          redirect_to :controller => 'auth', :action => 'index'
          return
        end

        # save session
        Salesforce::Authentication.save_session session, access_token
      end

    end

  end
  
end
