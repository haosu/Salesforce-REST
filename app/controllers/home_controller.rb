class HomeController < ApplicationController

  def index
    access_token = Salesforce::Authentication.get_token session

    resp = Salesforce::Rest.sobjects access_token
  end

end