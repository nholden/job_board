require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET new" do
    context "when not logged in" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in" do
      before(:each) do
        allow(controller).to receive_messages(:logged_in? => true)
      end
     
      it "redirects to root_url" do
        get :new
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        get :new
        expect(flash[:error]).to eql("Already logged in.")
      end
    end
  end

end
