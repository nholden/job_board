require 'rails_helper'

RSpec.describe ApplicationsController, :type => :controller do
  before(:each) do
    @employer = FactoryGirl.create(:user)
    @applicant = FactoryGirl.create(:applicant)
    @admin = FactoryGirl.create(:admin)
    @job = FactoryGirl.create(:job, user: @employer)
    @application = FactoryGirl.create(:application, user: @applicant, job: @job)
  end

  describe "GET #index" do
    context "when an employer looks up applications for a job" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
        get :index, job_id: @job.id
      end
 
      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "assigns @applications" do
        expect(assigns(:applications)).to eq(Application.where(job_id: @job.id))
      end

      it "assigns @job" do
        expect(assigns(:job)).to eq(@job)
      end
    end

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

    context "with no specified job or user" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @employer)
        get :index
      end

      it "redirects to root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You are not authorized to view these applications.")
      end
    end

    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        get :index, job_id: @job.id
      end

      it "redirects to root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You are not authorized to view these applications.")
      end
    end

    context "when logged in as another employer" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => FactoryGirl.create(:user))
        get :index, job_id: @job.id
      end

      it "redirects to root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        expect(flash[:error]).to eql("You are not authorized to view these applications.")
      end
    end

    context "when logged in as an admin" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @admin)
        get :index, job_id: @job.id
      end
 
      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "assigns @applications" do
        expect(assigns(:applications)).to eq(Application.where(job_id: @job.id))
      end

      it "assigns @job" do
        expect(assigns(:job)).to eq(@job)
      end
    end
  end

  describe "POST #create" do
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

      it "redirects to root_url" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(flash[:error]).to eql("You must be logged in as an applicant to apply.")
      end
    end

    context "when logged in as a different employer" do
      before(:each) do
        @employer = FactoryGirl.create(:user)
        allow(controller).to receive_messages(:current_user => @employer)
      end

      it "does not create a new application" do
        expect{post :create, application: {user_id: @applicant.id, job_id: @job.id}}.
          to change(Application.all, :count).by(0)
      end

      it "redirects to root_url" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        post :create, application: {user_id: @applicant.id, job_id: @job.id}
        expect(flash[:error]).to eql("You must be logged in as an applicant to apply.")
      end
    end  
  end 

  describe "DELETE #destroy" do
    context "when logged in as an applicant" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => @applicant)
      end

      it "destroys the application" do
        expect{delete :destroy, id: @application.id}.
          to change(Application.where(user_id: @applicant.id, 
                                      job_id: @job.id
                                     ), :count).by(-1)
      end

      it "redirects to root_url" do
        delete :destroy, id: @application.id
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        delete :destroy, id: @application.id
        expect(flash[:notice]).to eql("Application to '#{@job.title}' successfully retracted.")
      end
    end

    context "when not logged in" do
      it "does not destroy the application" do
        expect{delete :destroy, id: @application.id}.
          to change(Application.all, :count).by(0)
      end

      it "redirects to root_url" do
        delete :destroy, id: @application.id
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        delete :destroy, id: @application.id
        expect(flash[:error]).to eql("You must be logged in as an applicant to retract an application.")
      end
    end

    context "when logged in as a different employer" do
      before(:each) do
        @employer = FactoryGirl.create(:user)
        allow(controller).to receive_messages(:current_user => @employer)
      end

      it "does not destroy the application" do
        expect{delete :destroy, id: @application.id}.
          to change(Application.all, :count).by(0)
      end

      it "redirects to root_url" do
        delete :destroy, id: @application.id
        expect(response).to redirect_to(root_url)
      end

      it "sends a flash" do
        delete :destroy, id: @application.id
        expect(flash[:error]).to eql("You must be logged in as an applicant to retract an application.")
      end
    end  
  end
end
