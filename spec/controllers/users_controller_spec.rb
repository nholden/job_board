require 'rails_helper'

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
    context "with valid information" do
      it "creates a new user" do
        expect{ post :create, user: FactoryGirl.attributes_for(:user) }.to change(User,:count).by(1)
      end

      it "redirects to the homepage" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to root_url
      end
    end

    context "with non-mathing passwords" do
      it "does not create a new user" do
        expect{ post :create, user:     { :email =>                 "a@b.com",
                                          :password =>              "password",
                                          :password_confirmation => "loremipsu",
                                          :name =>                  "x",
                                          :website =>               "y",
        }}.to change(User,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, user:     { :email =>                 "a@b.com",
                                  :password =>              "password",
                                  :password_confirmation => "loremipsum",
                                  :name =>                  "x", 
                                  :website =>               "y" }
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
        }}.to change(User,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, user:     { :email =>                 "a@b..com",
                                  :password =>              "password",
                                  :password_confirmation => "password",
                                  :name =>                  "x", 
                                  :website =>               "y" }
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
        }}.to change(User,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, user:     { :email =>                 "a@b.com",
                                  :password =>              "password",
                                  :password_confirmation => "password",
                                  :name =>                  "", 
                                  :website =>               "y" }
        expect(response).not_to redirect_to root_url 
      end
    end
  end
end
