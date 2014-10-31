require 'rails_helper'

RSpec.describe EmployersController, :type => :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid information" do
      it "creates a new employer" do
        expect{ post :create, employer: FactoryGirl.attributes_for(:employer) }.to change(Employer,:count).by(1)
      end

      it "redirects to the homepage" do
        post :create, employer: FactoryGirl.attributes_for(:employer)
        expect(response).to redirect_to root_url
      end
    end

    context "with invalid information" do
      it "does not create a new employer" do
        expect{ post :create, employer: { :email =>                 "a@b.com",
                                          :password =>              "password",
                                          :password_confirmation => "loremipsum"
        }}.to change(Employer,:count).by(0)
      end

      it "does not redirect to the homepage" do
        post :create, employer: { :email => "a@b.com",
                                  :password => "password",
                                  :password_confirmation => "loremipsum" }
        expect(response).not_to redirect_to root_url 
      end
    end
  end
end
