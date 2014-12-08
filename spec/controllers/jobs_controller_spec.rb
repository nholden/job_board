require 'rails_helper'

RSpec.describe JobsController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "assigns @job" do
      get :new
      expect(assigns(:job)).to_not be_nil
    end
  end

  describe "POST #create" do
    context "with valid information" do
      it "creates a new job" do
        expect{ post :create, job: FactoryGirl.attributes_for(:job) }.to change(Job, :count).by(1)
      end
    end
  end
end
