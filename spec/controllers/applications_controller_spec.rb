require 'rails_helper'

RSpec.describe ApplicationsController, :type => :controller do
  describe "POST #create" do
    before(:each) do
      @applicant = FactoryGirl.create(:applicant)
      @job = FactoryGirl.create(:job)
    end

    context "when logged in as an applicant" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @applicant)
      end

      it "creates a new application" do
        expect{post :create, application: {user_id: @applicant.id, job_id: @job.id}}.
          to change(Application.where(user_id: @applicant.id, 
                                      job_id: @job.id
                                     ), :count).by(1)
      end

      it "redirects to root_url" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(flash[:notice]).to eql("Application to '#{@job.title}' successfully submitted.")
      end
    end

    context "when not logged in" do
      it "does not create a new application" do
        expect{post :create, application: {user_id: @applicant.id, job_id: @job.id}}.
          to change(Application.all, :count).by(0)
      end

      it "redirects to login" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(response).to redirect_to(login_path)
      end

      it "sends a flash" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(flash[:error]).to eql("You must be logged in to apply.")
      end
    end
  end 
end
