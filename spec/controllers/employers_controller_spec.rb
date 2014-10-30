require 'rails_helper'

RSpec.describe EmployersController, :type => :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "creating a new employer" do
    it "creates the new employer" do
      expect{ post :create, employer: FactoryGirl.attributes_for(:employer) }.to change(Employer,:count).by(1)
    end

    it "redirects to home page upon save" do
      post :create, employer: FactoryGirl.attributes_for(:employer)
      expect(response).to redirect_to root_url
    end
  end
end
