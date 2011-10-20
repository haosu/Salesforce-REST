module Salesforce
  module Data
    
    class Rest

      class << self
        def get_query_url access_token, query_string
          url = access_token.params['instance_url'] + SalesforceOAuth::Application.config.instance_version + query_string

          begin
            resp = access_token.get url
          rescue Exception => e
            # should get the error code 
            puts e.response.inspect

            errorCode = JSON.parse(e.response.body)[0]["errorCode"]

            case errorCode
            when "INVALID_SESSION_ID"
              # redirect to login
            else
              # stuff
            end

            resp = e.response
          end

          resp
        end

        def sobjects access_token, options = {"sobject"=>nil, "id"=>nil, "fields"=>nil, "action"=>nil}
          #options: sobject, id, fields, action
          
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
                url += "/#{options["id"]}"

                unless options["fields"].nil?
                  url += "?#{options["fields"]*","}"
                end
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
end