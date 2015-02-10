require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, :type => :controller do
  describe "GET #new" do
    context "when not logged in" do
      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end
    
    context "when logged in" do
      before(:each) do
        allow(controller).to receive_messages(:logged_in? => true)
      end

      it "redirects to root_url" do
        get :new
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash message" do
        get :new
        expect(flash[:error]).to eql("Already logged in.")
      end
    end
  end

  describe "POST #create" do
    before(:each) do
      @role = FactoryGirl.build(:role)
      @role.save
      @user_attributes = FactoryGirl.attributes_for(:user, role_id: @role.id)
    end

    context "with valid information" do
      it "creates a new user" do
        expect{ post :create, user: @user_attributes}.to change(User,:count).by(1)
      end

      it "redirects to the homepage" do
        post :create, user: @user_attributes
        expect(response).to redirect_to root_url
      end

      it "logs the user in" do
        post :create, user: @user_attributes
        expect(logged_in?).to eql(true)
      end
    end

    context "with non-macthing passwords" do
      it "does not create a new user" do
        expect{ post :create, user:    { :email =>                 "a@b.com",
                                         :password =>              "password",
                                         :password_confirmation => "loremipsum",
                                         :name =>                  "x", 
                                         :website =>               "y",
                                         :role_id =>               @role.id 
        }}.to change(User,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, user:     { :email =>                 "a@b.com",
                                  :password =>              "password",
                                  :password_confirmation => "loremipsum",
                                  :name =>                  "x", 
                                  :website =>               "y",
                                  :role_id =>               @role.id }
        expect(response).not_to redirect_to root_url 
      end
    end

    context "with invalid email" do
      it "does not create a new user" do
        expect{ post :create, user:     { :email =>                 "a@b..com",
                                          :password =>              "password",
                                          :password_confirmation => "password",
                                          :name =>                  "x",
                                          :website =>               "y",
                                          :role_id =>               @role.id
        }}.to change(User,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, user:     { :email =>                 "a@b..com",
                                  :password =>              "password",
                                  :password_confirmation => "password",
                                  :name =>                  "x", 
                                  :website =>               "y",
                                  :role_id =>               @role.id }
        expect(response).not_to redirect_to root_url 
      end
    end

    context "without a company name" do
      it "does not create a new user" do
        expect{ post :create, user:     { :email =>                 "a@b.com",
                                          :password =>              "password",
                                          :password_confirmation => "password",
                                          :name =>                  "",
                                          :website =>               "y",
                                          :role_id =>               @role.id
        }}.to change(User,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, user:     { :email =>                 "a@b.com",
                                  :password =>              "password",
                                  :password_confirmation => "password",
                                  :name =>                  "", 
                                  :website =>               "y",
                                  :role_id =>               @role.id }
        expect(response).not_to redirect_to root_url 
      end
    end
  end
end
