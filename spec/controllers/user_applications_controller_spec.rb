require 'rails_helper'

RSpec.describe UserApplicationsController, type: :controller do
  before(:each) do
    @applicant = FactoryGirl.create(:applicant)
    @job = FactoryGirl.create(:job)
    @application = FactoryGirl.create(:application, user: @applicant, job: @job)
  end

  describe "GET #index" do
    context "when an applicant looks up applications for himself" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @applicant)
        get :index
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "assigns @applications" do
        expect(assigns(:applications)).to eq(Application.where(user_id: @applicant.id))
      end
    end

    context "when not logged in" do
      before(:each) do
        get :index
      end

      it "redirects to root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in to view your applications.")
      end
    end
  end
end
