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
        get :new
      end

      it "redirects to root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash message" do
        expect(flash[:error]).to eql("Already logged in.")
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    context "when logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @user)
        get :edit, id: @user.id
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        get :edit, id: @user.id
      end

      it "redirects to login" do
        expect(response).to redirect_to('/login')
      end

      it "sends a flash message" do
        expect(flash[:error]).to eql("You must be logged in to your account to edit your profile.")
      end
    end
  end

  describe "PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    context "when logged in as the correct user" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @user)
      end

      context "with mismatched passwords" do
        before(:each) do
          patch :update, :id => @user.id, :user => { :password => "password",
                                        :password_confirmation => "loremips" }
          @user.reload
        end

        it "sends a flash message" do
          expect(flash[:error]).to eql("Password confirmation doesn't match Password")
        end
      end  
      
      context "with valid information" do
        before(:each) do
          patch :update, :id => @user.id, :user => { :name => "Lockheed Martin" }
          @user.reload
        end

        it "updates the job" do
          expect(@user.name).to eql("Lockheed Martin")
        end

        it "redirects to the homepage" do
          expect(response).to redirect_to(root_url)
        end
      end
    end
 
    context "when not logged in" do
      before (:each) do
        allow(controller).to receive_messages(:current_user => nil)
        patch :update, :id => @user.id, :job => { :name => "Lockheed Martin" }
        @user.reload
      end

      it "does not update the user" do
        expect(@user.name).to eql("Boeing")
      end

      it "redirects to the login page" do
        expect(response).to redirect_to('/login')
      end
    end
  end

  describe "GET #index" do
    before(:each) do
      @employer = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
    end

    context "when logged in as an administrator" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @admin)
        get :index
      end
   
      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context "when logged in as an employer" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
        get :index
      end

      it "redirects to the jobs page" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to manage users.")
      end
    end

    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        get :index
      end

      it "redirects to the login page" do
        expect(response).to redirect_to("/login")
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to manage users.")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @employer = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
    end

    context "when logged in as an administrator" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @admin)
      end

      it "deletes the user" do
        expect{ delete :destroy, id: @employer.id}.to change(Role.find_or_create_by(label: 'employer').users,:count).by(1)
      end

      it "redirects to the users page" do
        delete :destroy, id: @employer.id
        expect(response).to redirect_to('/users')
      end

      it "sends a flash" do
        delete :destroy, id: @employer.id
        expect(flash[:notice]).to eql("User successfully deleted.")
      end
    end

    context "when logged in as an employer" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
      end

      it "does not delete the user" do
        expect{ delete :destroy, id: @employer.id}.to change(Role.find_or_create_by(label: 'employer').users,:count).by(0)
      end

      it "redirects to the jobs page" do
        delete :destroy, id: @employer.id
        expect(response).to redirect_to('/jobs')
      end

      it "sends a flash" do
        delete :destroy, id: @employer.id
        expect(flash[:error]).to eql("You must be logged in as an administrator to delete users.")
      end
    end

    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        delete :destroy, id: @employer.id
      end

      it "does not delete the user" do
        expect{ delete :destroy, id: @employer.id}.to change(Role.find_or_create_by(label: 'employer').users,:count).by(0)
      end

      it "redirects to the login page" do
        delete :destroy, id: @employer.id
        expect(response).to redirect_to('/login')
      end

      it "sends a flash" do
        delete :destroy, id: @employer.id
        expect(flash[:error]).to eql("You must be logged in as an administrator to delete users.")
      end
    end
  end

  describe "POST #create" do
    before(:each) do
      @user_attributes = FactoryGirl.attributes_for(:user)
    end

    context "when there is no admin acccount" do
      it "creates a new admin" do
        expect{ post :create, user: @user_attributes}.to change(Role.find_or_create_by(label: 'admin').users,:count).by(1)
      end
    end

    context "when there is an admin account" do
      before(:each) do
        FactoryGirl.build(:admin).save
      end

      context "with valid information" do
        it "creates a new employer" do
          expect{ post :create, user: @user_attributes}.to change(Role.find_or_create_by(label: 'employer').users,:count).by(1)
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
                                           :website =>               "y"
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
                                            :website =>               "y"
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
                                            :website =>               "y" 
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
end
