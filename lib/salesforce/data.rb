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

    end

  end
end