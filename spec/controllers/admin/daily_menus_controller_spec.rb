require 'rails_helper'

RSpec.describe Admin::DailyMenusController, type: :controller do
  
  describe "unathenticated user" do 
    
    let(:daily_menu) { create(:daily_menu) }
    
    describe "GET /index" do
      it "redirects to login page with alert flash" do 
        get :index
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "GET /show" do
      it "redirects to login page with alert flash" do 
        get :show, params: { id: daily_menu}
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "GET /new" do
      it "redirects to login page with alert flash" do 
        get :new
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "POST /create" do
      it "redirects to login page with alert flash" do 
        post :create, params: { id: daily_menu}
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /edit" do
      it "redirects to login page with alert flash" do 
        get :edit, params: { id: daily_menu}
        expect(response).to redirect_to(new_user_session_url) 
        expect(flash[:alert]).to be_present 
      end
    end

    describe "PATCH /update" do
      it "redirects to login page with alert flash" do 
        patch :update, params: { id: daily_menu }
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to be_present  
      end
    end
  end

  describe "authorized user" do 
    
    let(:daily_menu) { create(:daily_menu) }
    let(:user) {create(:user)}
    
    before do
      user.update(is_admin: false)
      sign_in(user)
    end
    
    describe "GET /index" do
      it "redirects to root path with alert flash" do 
        get :index
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /show" do
      it "redirects to root path with alert flash" do 
        get :show, params: { id: daily_menu}
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /new" do
      it "redirects to root path with alert flash" do 
        get :new
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to be_present  
      end
    end

    describe "POST /create" do
      it "redirects to root path with alert flash" do 
        post :create, params: { id: daily_menu}
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to be_present  
      end
    end

    describe "GET /edit" do
      it "redirects to root path with alert flash" do 
        get :edit, params: { id: daily_menu}
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to be_present  
      end
    end

    describe "PATCH /update" do
      it "redirects to root path with alert flash" do 
        patch :update, params: { id: daily_menu }
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to be_present  
      end
    end
  end

  describe "authorized admin" do 
    
    let(:daily_menu) { create(:daily_menu)  }
    let(:user) { create(:user) }

    before do
      user.update(is_admin: true)
      sign_in(user)
    end

    describe "GET /index" do
      
      it "renders index page" do 
        get :index
        expect(response).to render_template(:index) 
      end
      
      it "assigns @daily_menus" do
        get :index
        expect(assigns(:daily_menus)).to eq([daily_menu])
      end
    end

    describe "GET /show" do
      
      it "renders show page" do 
        get :show, params: { id: daily_menu}
        expect(response).to render_template(:show) 
      end

      it "assigns requested daily_menu to @daily_menu" do
        get :show, params: { id: daily_menu}
        expect(assigns(:daily_menu)).to eq(daily_menu)
      end
    end

    describe "GET /new" do
      
      it "renders new page" do 
        get :new
        expect(response).to render_template(:new) 
      end
      
      it "assigns new daily_menu to @daily_menu" do
        get :new
        expect(assigns(:daily_menu)).to be_a_new(DailyMenu)
      end
    end

    describe "POST /create" do
      context "valid food_items data" do
        subject { post :create, params: {daily_menu: {food_items_attributes: [attributes_for(:food_item)]}}}
        it "redirects to admin_daily_menu_path(@dailymenu)" do
          expect(subject).to redirect_to(admin_daily_menu_path(assigns(:daily_menu)))
        end
        it "creates new daily_menu in database" do
          expect{ subject }.to change { DailyMenu.count }.by(1) 
        end
        it "creates new food_item in database" do
          expect{ subject }.to change { FoodItem.count }.by(1) 
        end
      end

      context "invalid food_items data" do
        subject { post :create, params: {daily_menu: {food_items_attributes: [attributes_for(:food_item, name: "")]}}}
        it "renders #new" do
          expect(subject).to render_template(:new)
        end
        it "doesn`t create new food_item in database " do
          expect{ subject }.not_to change { FoodItem.count } 
        end
        it "doesn`t create new daily_menu in database " do
          expect{ subject }.not_to change { DailyMenu.count } 
        end
      end
    end

    describe "GET /edit" do
      
      it "renders edit page" do 
        get :edit, params: { id: daily_menu}
        expect(response).to render_template(:edit) 
      end
      
      it "assigns requested daily_menu to @daily_menu" do
        get :show, params: { id: daily_menu}
        expect(assigns(:daily_menu)).to eq(daily_menu)
      end
    end

    describe "PATCH /update" do
      
      let(:daily_menu) { create(:daily_menu) }

      before do
        create(:food_item, name: "new", daily_menu: daily_menu)
      end
      
      context "add/delete associated food_items" do
        
        let(:deleted_food_item) { attributes_for(:food_item, _destroy: true, id: daily_menu.food_items.first) }
        let(:new_food_item) { attributes_for(:food_item) }
        
        it "removes food_item from db" do
          patch :update, params: { id: daily_menu, daily_menu: { food_items_attributes: [deleted_food_item] }}
          expect(daily_menu.food_items.size).to eq(0)
        end
        
        it "adds new food_item to db" do
          expect {
          patch :update, params: { id: daily_menu, daily_menu: { food_items_attributes: [new_food_item] }}
          }.to change(FoodItem, :count).by(1)
        end
      end
  
      context "valid food_item data" do
        
        let(:valid_food_item) { attributes_for(:food_item, name: "super new", id: daily_menu.food_items.first) }

        it "redirects to admin_daily_menu_path(@daily_menu)" do 
          patch :update, params: { id: daily_menu, daily_menu: { food_items_attributes: [valid_food_item] }}
          expect(response).to redirect_to(admin_daily_menu_path(daily_menu))
        end

        it "updates food_item" do
          patch :update, params: { id: daily_menu, daily_menu: { food_items_attributes: [valid_food_item] }}
          expect(daily_menu.food_items.first.name).to eq("super new")  
        end
      end

      context "invald food_item data" do
        
        let(:invalid_food_item) { attributes_for(:food_item, name: "", id: daily_menu.food_items.first) }

        it "renders #edit" do 
          patch :update, params: { id: daily_menu, daily_menu: { food_items_attributes: [invalid_food_item] }}
          expect(response).to render_template(:edit)
        end

        it "doesn`t update food_item" do
          patch :update, params: { id: daily_menu, daily_menu: { food_items_attributes: [invalid_food_item] }}
          expect(daily_menu.food_items.first.name).not_to eq("")  
        end
      end


    end
  end  
end
