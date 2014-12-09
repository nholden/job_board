require 'rails_helper'

RSpec.describe JobsController, :type => :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    context "when not logged in" do

      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to('/login')
      end

      it "sends a flash message" do
        get :new
        expect(flash[:error]).to eql("You must be logged in to create a job.")
      end
    end

    context "when logged in" do
      before(:each) do
        allow(controller).to receive_messages(:logged_in? => true)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end

      it "assigns @job" do
        get :new
        expect(assigns(:job)).to_not be_nil
      end
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
