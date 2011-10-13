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

    instance_url = access_token.params['instance_url']

    # lol not secure
    #session[:oauth_code] = code
    session[:oauth_access_token] = access_token.token
    session[:oauth_refresh_token] = access_token.refresh_token
    session[:oauth_expires_at] = access_token.expires_at
    session[:oauth_instace_url] = instance_url

    redirect_to :controller => 'home', :action => 'index'
  end

  def reset
    logout_url = "home#index"

    unless session[:oauth_instace_url].nil?
      logout_url = session[:oauth_instace_url] + '/secur/logout.jsp'
    end

    reset_session

    redirect_to logout_url
  end

end