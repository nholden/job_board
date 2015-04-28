require 'rails_helper'

RSpec.describe ApplicationsController, :type => :controller do
  describe "POST #create" do
    before (:each) do
      @application_attributes = FactoryGirl.attributes_for(:application)
    end

    it "creates a new application" do
      expect{post :create, application: @application_attributes}.
        to change(Application.where(job_id: @application_attributes[:job_id], 
                                    user_id: @application_attributes[:user_id],
                                    status: "Submitted"
                                   ), :count).by(1)
    end

    it "redirects to root_url" do
      post :create
      expect(response).to redirect_to(root_url)
    end

    it "sends a flash" do
      post :create
      expect(flash[:notice]).to eql("Application successfully submitted.")
    end
  end 
end
