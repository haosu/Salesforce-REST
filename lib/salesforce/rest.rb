module Salesforce
  class Rest

    class << self
      def get_url_query access_token, query_string
        access_token.get query_string
      end

      def get_sobjects
      end

      def get_sobjects_describe


    end

  end
end