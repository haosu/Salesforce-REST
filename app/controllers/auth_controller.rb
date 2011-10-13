class AuthController < ApplicationController
  skip_before_filter :authenticate

  def index
    url = client.auth_code.authorize_url(
      :redirect_uri => SalesforceOAuth::Application.config.redirect_uri,
      :response_type => 'code'
    )

    redirect_to url
  end

  def callback
    code = params[:code].to_s

    access_token = client.auth_code.get_token(
      code,
      :redirect_uri => SalesforceOAuth::Application.config.redirect_uri,
      :grant_type => 'authorization_code'
    )

    # API URL
    instance_url = access_token.params['instance_url'] + SalesforceOAuth::Application.config.instance_version

    puts access_token.inspect

    # lol not secure
    #session[:oauth_code] = code
    session[:oauth_access_token] = access_token.token
    session[:oauth_refresh_token] = access_token.refresh_token
    session[:oauth_expires_at] = access_token.expires_at

    redirect_to :controller => 'home', :action => 'index'
  end

  def reset
    reset_session
  
    puts session.to_json

    redirect_to :controller => 'home', :action => 'index'
  end

end