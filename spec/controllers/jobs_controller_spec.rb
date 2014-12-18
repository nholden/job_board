require 'rails_helper'

RSpec.describe JobsController, :type => :controller do
  describe "GET #index" do
    before(:each) { get :index }

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should assign @jobs" do
      expect(:jobs).to_not be_nil
    end 
  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_jobs)
      get :show, id: @user.jobs.first.id
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

    it "should assign @job" do
      expect(:job).to_not be_nil
    end
  end

  describe "GET #edit" do
    context "when not logged in" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_jobs)
        get :edit, id: @user.jobs.first.id
      end

      it "redirects to the login page" do
        expect(response).to redirect_to('/login')
      end

      it "sends a flash message" do
        expect(flash[:error]).to eql("You must be logged in to create a job.")
      end
    end

    context "when logged in as correct user" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_jobs)
        allow(controller).to receive_messages(:current_user => @user)
        get :edit, id: @user.jobs.first.id
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end

      it "should assign @job" do
        expect(:job).to_not be_nil
      end
    end
  end

  describe "GET #new" do

    context "when not logged in" do
      before(:each) { get :new }

      it "redirects to the login page" do
        expect(response).to redirect_to('/login')
      end

      it "sends a flash message" do
        expect(flash[:error]).to eql("You must be logged in to create a job.")
      end
    end

    context "when logged in" do
      before(:each) do
        allow(controller).to receive_messages(:logged_in? => true)
        get :new
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end

      it "assigns @job" do
        expect(assigns(:job)).to_not be_nil
      end
    end
  end

  describe "POST #create" do
    context "with valid information" do
      before(:each) do
        @user = FactoryGirl.build(:user_with_jobs)
        @user.save
      end

      it "creates a new job" do
        @user.jobs.each do |job|
          expect{ post :create, job: job}.to change(Job, :count).by(1)
        end
      end
    end
  end

  describe "PATCH #update" do
    context "with valid information" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_jobs)
        @user.save
        @job = @user.jobs.first
      end

      it "updates the job" do
        patch :update, :id => @job.id, :job => { :title => "Astronaut" }
        @job.reload
        @job.title.should == "Astronaut"
      end
    end
  end
end
