module Salesforce
  class Authentication

    class << self
      # static client
      def client
        OAuth2::Client.new(
          SalesforceOAuth::Application.config.api_key, 
          SalesforceOAuth::Application.config.api_secret, 
          :site => SalesforceOAuth::Application.config.rest_site,
          :authorize_url => SalesforceOAuth::Application.config.authorize_path,
          :token_url => SalesforceOAuth::Application.config.access_token_path
        )
      end

      def refresh_session access_token
        access_token.refresh! 
      end

      def save_token session, access_token
        # lol not secure
        #session[:oauth_code] = code
        session[:oauth_access_token] = access_token.token
        session[:oauth_refresh_token] = access_token.refresh_token
        session[:oauth_expires_at] = access_token.expires_at
        session[:oauth_expires_in] = access_token.expires_in
        session[:oauth_instace_url] = access_token.params['instance_url']
      end

      def get_token session
        OAuth2::AccessToken.new(
          self.client,
          session[:oauth_access_token], 
          {
            "expires_in" => session[:oauth_expires_in],
            "expires_at" => session[:oauth_expires_at],
            "refresh_token" => session[:oauth_refresh_token],
            "instance_url" => session[:oauth_instace_url]
          }
        )
      end

    end
    
  end
end