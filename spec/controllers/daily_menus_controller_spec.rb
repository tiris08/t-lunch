require 'rails_helper'

RSpec.describe DailyMenusController do
  context "user" do
    describe "GET /index" do
      it "redirects to login page" do 
        get :index
        expect(response).to redirect_to(new_user_session_url) 
      end
    end
  end
end
