require 'rails_helper'

RSpec.describe Admin::DailyMenusController, type: :controller do
  
  describe "GET /index" do
    it "redirects to login page" do 
      get :index
      expect(response).to redirect_to(new_user_session_url) 
    end
  end

  describe "GET /new" do
    it "redirects to login page" do 
      get :new
      expect(response).to redirect_to(new_user_session_url) 
    end
  end
end
