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
        get :index, user_id: @applicant.id
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "assigns @applications" do
        expect(assigns(:applications)).to eq(Application.where(user_id: @applicant.id))
      end
    end
  end
end
