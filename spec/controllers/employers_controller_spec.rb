require 'rails_helper'

RSpec.describe EmployersController, :type => :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "creating a new employer" do
    it "responds to create" do
      post :create
      expect(response).to be_success
    end
  end
end
