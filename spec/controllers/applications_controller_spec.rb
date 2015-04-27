require 'rails_helper'

RSpec.describe ApplicationsController, :type => :controller do
  describe "POST #create" do
    before (:each) do
      @application_attributes = FactoryGirl.attributes_for(:application)
    end

    it "creates a new application" do
      expect{post :create, application: @application_attributes}.to
        change(Application.all, :count).by(1)
    end
  end 
end
