class AuthController < ApplicationController
  skip_before_filter :authenticate

  def index
    url = client.auth_code.authorize_url(
      :redirect_uri => SalesforceOAuth::Application.config.redirect_uri,
      :response_type => 'code'
    )

    puts client.to_json

    redirect_to url
  end

  def callback
    access_token = client.web_server.get_access_token(
      params[:code].to_s,
      :redirect_uri => SalesforceOAuth::Application.config.redirect_uri,
      :grant_type => 'authorization_code'
    )
  end

end