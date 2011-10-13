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

      def refresh_session refresh_token
        client_value                         = client(key, secret)
        client_value.connection.ssl[:verify] = false
        token                                = OAuth2::AccessToken.refresh_token(client_value, refresh_token)
      end

    end
    
  end
end