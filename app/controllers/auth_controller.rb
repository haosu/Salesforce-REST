require 'salesforce'

class AuthController < ApplicationController
  skip_before_filter :authenticate

  def index

    url = Salesforce::Authentication.client.auth_code.authorize_url(
      :redirect_uri => SalesforceOAuth::Application.config.redirect_uri,
      :response_type => 'code'
    )

    redirect_to url
  end

  def callback
    code = params[:code].to_s

    access_token = Salesforce::Authentication.client.auth_code.get_token(
      code,
      :redirect_uri => SalesforceOAuth::Application.config.redirect_uri,
      :grant_type => 'authorization_code'
    )

    Salesforce::Authentication.save_token session, access_token

    redirect_to :controller => 'home', :action => 'index'
  end

  def reset
    logout_url = "home#index"

    unless session[:oauth_instace_url].nil?
      logout_url = session[:oauth_instace_url] + SalesforceOAuth::Application.config.logout_endpoint
    end

    reset_session

    redirect_to logout_url
  end

  def refresh
    # BROKEN!
    # does not recreate the access_token correctly
    access_token = Salesforce::Authentication.get_token session
    
    access_token = Salesforce::Authentication.refresh_session access_token

    Salesforce::Authentication.save_token session, access_token

    render :json => access_token.to_json
  end

end