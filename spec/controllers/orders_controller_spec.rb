require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  
  context "unathenticated user" do 
    
    let(:daily_menu) { create(:daily_menu) }
    let(:food_items) { create_list(:food_item, 3, daily_menu: daily_menu)}
    let(:order_with_order_items) {create(:order, daily_menu: daily_menu, 
                                          order_items_attributes: { "0": {food_item: food_items[0]},
                                                                    "1": {food_item: food_items[1]},
                                                                    "2": {food_item: food_items[2]} })}

    
    describe "GET /new" do
      it "redirects to login page with alert flash" do 
        get :new, params: {daily_menu_id: daily_menu}
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "POST /create" do
      it "redirects to login page with alert flash" do 
        post :create, params: { daily_menu_id: daily_menu, order: attributes_for(:order), 
                                order_items_attributes: attributes_for(:order_item) }
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /edit" do
      it "redirects to login page with alert flash" do 
        get :edit, params: { daily_menu_id: daily_menu, id: order_with_order_items}
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "PATCH /update" do
      it "redirects to login page with alert flash" do 
        patch :update, params: { daily_menu_id: daily_menu, id: order_with_order_items, order: attributes_for(:order) }
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present  
      end
    end

    describe "DELETE /destroy" do
      it "redirects to login page with alert flash" do 
        delete :destroy, params: { daily_menu_id: daily_menu, id: order_with_order_items}
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present  
      end
    end
  end
  

  context "authorized admin:user" do 
    
    let(:daily_menu) { create(:daily_menu) }
    let(:food_items) { create_list(:food_item, 3, daily_menu: daily_menu)}
    let(:order_with_order_items) {create(:order, daily_menu: daily_menu, 
                                          order_items_attributes: { "0": {food_item: food_items[0]},
                                                                    "1": {food_item: food_items[1]},
                                                                    "2": {food_item: food_items[2]} })}

    let(:admin) {create(:random_user)}
    
    before do
      admin.update(is_admin: true)
      sign_in(admin)
    end
    
    describe "GET /new" do
      it "redirects to admin_root with alert flash" do 
        get :new, params: {daily_menu_id: daily_menu}
        expect(response).to redirect_to(admin_root_path) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "POST /create" do
      it "redirects to admin_root with alert flash" do 
        post :create, params: { daily_menu_id: daily_menu, order: attributes_for(:order) }
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /edit" do
      it "redirects to admin_root with alert flash" do 
        get :edit, params: { daily_menu_id: daily_menu, id: order_with_order_items}
        expect(response).to redirect_to(admin_root_path) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "PATCH /update" do
      it "redirects to admin_root with alert flash" do 
        patch :update, params: { daily_menu_id: daily_menu, id: order_with_order_items, order: attributes_for(:order) }
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:alert]).to be_present  
      end
    end

    describe "DELETE /destroy" do
      it "redirects to admin root with alert flash" do 
        delete :destroy, params: { daily_menu_id: daily_menu, id: order_with_order_items}
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:alert]).to be_present  
      end
    end
  end
  
  # context "authorized user" do 

  #   let(:daily_menu) { create(:daily_menu) }
  #   let(:food_items) { create_list(:food_item, 3, daily_menu: daily_menu)}
  #   let(:order_with_order_items) {create(:order, daily_menu: daily_menu, 
  #                                       order_items_attributes: { "0": {food_item: food_items[0]},
  #                                                                 "1": {food_item: food_items[1]},
  #                                                                 "2": {food_item: food_items[2]} })}
  #   let(:user) {create(:random_user)}
    
  #   before do
  #     user.update(is_admin: false)
  #     sign_in(user)
  #   end

  #   describe "GET /new" do
      
  #     it "renders :new template" do 
  #       get :new, params: {daily_menu_id: daily_menu}
  #       expect(response).to render_template(:new) 
  #     end

  #     it "assigns new order to @order" do
  #       get :new, params: {daily_menu_id: daily_menu}
  #       expect(assigns(:order)).to be_a_new(Order) 
  #     end
  #   end

    # describe "POST /create" do
      
    #   context "without order_items" do
        
    #     xit "renders :new" do 
    #       post :create, params: { daily_menu_id: daily_menu, 
    #                               order: {daily_menu_id: daily_menu, user_id: user}}
    #       expect(response).to render_template(:new)
    #     end
        
    #     xit "doesn`t create new order in db" do
    #       expect{ 
    #         post :create, params: { daily_menu_id: daily_menu, 
    #                                 order: {daily_menu_id: daily_menu, user_id: user}}
    #         }.not_to change(Order, :count)
    #     end  
    #   end

    #   context "with valid order_items" do
        
    #     it "redirects to daily_menu_path(@daily_menu)" do
    #     end

    #     it "creates new order_items in database"
    #     end          
    #   end
    # end

    # describe "GET /edit" do
    #   it "renders :edit temolate" do 
      
    #   end
    # end

    # describe "PATCH /update" do
      
    #   it "redirects to daily_menu path" do 
      
    #   end

    #   it "updates order items in database" do
        
    #   end
      
    # end

    # describe "DELETE /destroy" do
      
    #   it "redirects to daily menu path" do 
      
    #   end

    #   it "deletes order_items from database" do
      
    #   end
    # end
  # end  
end
