class HomeController < ApplicationController

  def index
    access_token = Salesforce::Authentication.get_token session

    resp = Salesforce::Data.sobject_record access_token, "Account", "001U00000047omo"

    render :json => resp.body
  end

end