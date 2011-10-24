module Salesforce
  module Data

    class << self
      def sobjects access_token
        Salesforce::Data::Rest.sobjects access_token
      end

      def sobject_metadata access_token, sobject
        Salesforce::Data::Rest.sobjects access_token, {"sobject" => sobject}
      end

      def sobject_describe access_token, sobject
        Salesforce::Data::Rest.sobjects access_token, {"sobject" => sobject, "action"=>"describe"}
      end

      def sobject_record access_token, sobject, id
        Salesforce::Data::Rest.sobjects access_token, {"sobject" => sobject, "id" => id}
      end

      def feed_news access_token, id
        Salesforce::Data::Rest.chatter access_token, {"feed" => true, "type" => "news", "id" => id}
      end

      def feed_record access_token, id
        Salesforce::Data::Rest.chatter access_token, {"feed" => true, "type" => "record", "id" => id}
      end

      def feed_user access_token, id  
        Salesforce::Data::Rest.chatter access_token, {"feed" => true, "type" => "user", "id" => id}
      end

      def feed_profile access_token, id
        Salesforce::Data::Rest.chatter access_token, {"feed" => true, "type" => "user-profile", "id" => id}
      end

      #add other functions
      #topics
      #search
      #to
      #messages
      #groups
      #users
      
      #http://www.salesforce.com/us/developer/docs/chatterapipre/index.htm

    end

  end
end