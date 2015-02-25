require 'rails_helper'
RSpec.describe SettingsController, :type => :controller do

before(:each) do
  @employer = FactoryGirl.create(:user)
  @admin = FactoryGirl.create(:admin)
end

  describe "GET edit" do
    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        get :edit
      end

      it "redirects to the login page" do
        expect(response).to redirect_to("/login")
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to edit settings.")
      end
    end

    context "when logged in as an employer" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
        get :edit
      end

      it "redirects to the jobs page" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to edit settings.")
      end
    end

    context "when logged in as an admin" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @admin)
        get :edit
      end

      it "returns http success" do
        get :edit
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT update_experiences" do
    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        put :update_experiences
      end

      it "redirects to the login page" do
        expect(response).to redirect_to("/login")
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to edit settings.")
      end
    end

    context "when logged in as an employer" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
        put :update_experiences
      end

      it "redirects to the jobs page" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to edit settings.")
      end
    end

    context "when logged in as an admin" do
      before(:each) do
        @term1 = FactoryGirl.create(:term, label: "Term 1")
        @term2 = FactoryGirl.create(:term, label: "Term 2")
        @experience1 = FactoryGirl.create(:experience, label: "Experience 1")
        @experience2 = FactoryGirl.create(:experience, label: "Experience 2")
        allow(controller).to receive_messages(:current_user => @admin)
      end

      it "creates the new experience" do
        expect{ 
          put :update_experiences,
              @experience1.id.to_s => @experience1.label,
              @experience2.id.to_s => @experience2.label,
              :new_experiences => ["Experience 3", "", "", "", ""] 
        }.to change(Experience.all, :count).by(1)
      end
    end
  end

  describe "PUT update_terms" do
    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        put :update_terms
      end

      it "redirects to the login page" do
        expect(response).to redirect_to("/login")
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to edit settings.")
      end
    end

    context "when logged in as an employer" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
        put :update_terms
      end

      it "redirects to the jobs page" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You must be logged in as an administrator to edit settings.")
      end
    end

    context "when logged in as an admin" do
      before(:each) do
        @term1 = FactoryGirl.create(:term, label: "Term 1")
        @term2 = FactoryGirl.create(:term, label: "Term 2")
        @experience1 = FactoryGirl.create(:experience, label: "Experience 1")
        @experience2 = FactoryGirl.create(:experience, label: "Experience 2")
        allow(controller).to receive_messages(:current_user => @admin)
      end

      it "creates the new term" do
        expect{ 
          put :update_terms,
              @term1.id.to_s => @term1.label,
              @term2.id.to_s => @term2.label,
              :new_terms => ["Term 3", "", "", "", ""] 
        }.to change(Term.all, :count).by(1)
      end
    end
  end
end
