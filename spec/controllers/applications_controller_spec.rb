require 'rails_helper'

RSpec.describe ApplicationsController, :type => :controller do
  describe "POST #create" do
    before(:each) do
      @applicant = FactoryGirl.create(:applicant)
      @job = FactoryGirl.create(:job)
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
end
