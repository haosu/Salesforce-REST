module Salesforce
  class Rest

    class << self
      def get_query_url access_token, query_string
        url = access_token.params['instance_url'] + SalesforceOAuth::Application.config.instance_version + query_string

        begin
          resp = access_token.get url
        rescue Exception => e
          puts e.response.inspect
        end

        resp
      end

      def sobjects access_token, options = nil
        #options: sobject, id, fields, action
        if options.nil?
          options = {
            "sobject" => nil,
            "id" => nil,
            "fields" => [],
            "action" => nil
          }
        end

        url = "/sobjects/#{options["sobject"]}"

        # "#{options.sobject}/#{options.action}/#{options.id}?#{options.fields*","}"

        case options["sobject"]
        when "attachment"
          # drop the ID in
          url += "/#{options["id"]}"
        else

          case options["action"]
          when "describe"
            url += "/#{options["action"]}"
          else
            unless options["id"].nil?
              url += "/#{options["id"]}?#{options["fields"]*","}"
            end
          end

        end

        self.get_query_url access_token, url
      end

      def search access_token, string
        self.get_query_url access_token, string
      end

      def query access_token, string
        self.get_query_url access_token, string
      end

      def recent access_token, string
        self.get_query_url access_token, string
      end


    end

  end
end