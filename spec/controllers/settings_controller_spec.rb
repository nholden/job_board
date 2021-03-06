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
        @unspecified_exp = FactoryGirl.create(:experience, label: "Unspecified")
        @job1 = FactoryGirl.create(:job, experience: @experience1, term: @term1)
        allow(controller).to receive_messages(:current_user => @admin)
      end

      it "creates the new experience" do
        expect{ 
          put :update_experiences,
              "experience_" + @experience1.id.to_s => @experience1.label,
              "experience_" + @experience2.id.to_s => @experience2.label,
              :new_experiences => ["Experience 3", "", "", "", ""], 
              :new_experience_positions => ["3", "4", "5", "6", "7"]
        }.to change(Experience.all, :count).by(1)
      end

      it "assigns the new experience's position" do
        put :update_experiences,
            "experience_" + @experience1.id.to_s => @experience1.label,
            "experience_" + @experience1.id.to_s + "_position" => "5",
            "experience_" + @experience2.id.to_s => @experience2.label, 
            "experience_" + @experience2.id.to_s + "_position" => "4",
            :new_experiences => ["Bottom Experience", "Top Experience", "", "", ""],
            :new_experience_positions => ["10", "1", "3", "4", "5"]
        expect(Experience.find_by(position: 1).label).to eql("Top Experience")
        expect(Experience.find_by(position: 2).label).to eql(@experience2.label)
        expect(Experience.find_by(position: 3).label).to eql(@experience1.label)
        expect(Experience.find_by(position: 4).label).to eql("Bottom Experience")
      end

      it "updates an existing experience" do
        put :update_experiences,
            "experience_" + @experience1.id.to_s => "Edited experience 1",
            "experience_" + @experience2.id.to_s => @experience2.label, 
            :new_experiences => [""]
        expect(Experience.find_by label: "Edited experience 1").to_not be_nil
      end

      it "deletes blank experiences" do
        expect{ 
          put :update_experiences,
              "experience_" + @experience1.id.to_s => "",
              "experience_" + @experience2.id.to_s => @experience2.label,
              :new_experiences => ["", "", "", "", ""] 
        }.to change(Experience.where(label: "Experience 1"), :count).by(-1)
      end

      it "reassigns jobs with deleted experiences" do
        expect{ 
          put :update_experiences,
              "experience_" + @experience1.id.to_s => "",
              "experience_" + @experience2.id.to_s => @experience2.label,
              :new_experiences => ["", "", "", "", ""] 
        }.to change(Job.where(experience: @unspecified_exp), :count).by(1) 
      end  

      it "deletes the unassigned experience with no jobs" do
        expect{ 
          put :update_experiences,
              "experience_" + @unspecified_exp.id.to_s => ""
        }.to change(Experience.where(label: "Unspecified"), :count).by(-1)
      end

      it "fails to delete the unassigned experience with jobs" do
        FactoryGirl.create(:job, experience: @unspecified_exp)
        expect{ 
          put :update_experiences,
              "experience_" + @unspecified_exp.id.to_s => ""
        }.to change(Experience.where(label: "Unspecified"), :count).by(0)
      end

      it "repositions experiences" do
        put :update_experiences,
            "experience_" + @experience1.id.to_s => @experience1.label,
            "experience_" + @experience1.id.to_s + "_position" => "2",
            "experience_" + @experience2.id.to_s => @experience2.label, 
            "experience_" + @experience2.id.to_s + "_position" => "1",
            :new_experiences => [""]
        expect(Experience.find_by(position: 1).id).to eql(@experience2.id)
        expect(Experience.find_by(position: 2).id).to eql(@experience1.id)
      end

      it "raises a flash if two experiences are assigned the same position" do
        put :update_experiences,
            "experience_" + @experience1.id.to_s => @experience1.label,
            "experience_" + @experience1.id.to_s + "_position" => "3",
            "experience_" + @experience2.id.to_s => @experience2.label, 
            "experience_" + @experience2.id.to_s + "_position" => "3",
            :new_experiences => [""]
        expect(flash[:error]).to eql("Multiple experiences can't have the same position.")
      end
        
      it "sends a flash" do
        put :update_experiences
        expect(flash[:notice]).to eql("Experiences saved.")
      end
    end
  end

  describe "DELETE destroy_experience" do
    before(:each) do
      @term1 = FactoryGirl.create(:term, label: "Term 1")
      @term2 = FactoryGirl.create(:term, label: "Term 2")
      @experience1 = FactoryGirl.create(:experience, label: "Experience 1")
      @experience2 = FactoryGirl.create(:experience, label: "Experience 2")
      @unspecified_exp = FactoryGirl.create(:experience, label: "Unspecified")
      @job1 = FactoryGirl.create(:job, experience: @experience1, term: @term1)
    end

    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        delete :destroy_experience, id: @experience1.id
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
        delete :destroy_experience, id: @experience1.id
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
      end

      it "deletes the experience" do
        expect{ delete :destroy_experience, id: @experience1.id }.to change( 
          Experience.where(label: "Experience 1"), :count).by(-1)
      end

      it "reassigns jobs with deleted experiences" do
        expect{ delete :destroy_experience, id: @experience1.id }.to change(
          Job.where(experience: @unspecified_exp), :count).by(1) 
      end  

      it "deletes the unassigned experience with no jobs" do
        expect{ delete :destroy_experience, id: @unspecified_exp.id }.to change( 
          Experience.where(label: "Unspecified"), :count).by(-1)
      end

      it "fails to delete the unassigned experience with jobs" do
        FactoryGirl.create(:job, experience: @unspecified_exp)
        expect{ delete :destroy_experience, id: @unspecified_exp.id }.to change( 
          Experience.where(label: "Unspecified"), :count).by(0)
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
        @unspecified_term = FactoryGirl.create(:term, label: "Unspecified")
        @job1 = FactoryGirl.create(:job, experience: @experience1, term: @term1)
        allow(controller).to receive_messages(:current_user => @admin)
      end

      it "creates the new term" do
        expect{ 
          put :update_terms,
              "term_" + @term1.id.to_s => @term1.label,
              "term_" + @term2.id.to_s => @term2.label,
              :new_terms => ["Term 3", "", "", "", ""], 
              :new_term_positions => ["3", "4", "5", "6", "7"]
        }.to change(Term.all, :count).by(1)
      end

      it "assigns the new term's position" do
        put :update_terms,
            "term_" + @term1.id.to_s => @term1.label,
            "term_" + @term1.id.to_s + "_position" => "5",
            "term_" + @term2.id.to_s => @term2.label, 
            "term_" + @term2.id.to_s + "_position" => "4",
            :new_terms => ["Bottom Term", "Top Term", "", "", ""],
            :new_term_positions => ["10", "1", "3", "4", "5"]
        expect(Term.find_by(position: 1).label).to eql("Top Term")
        expect(Term.find_by(position: 2).label).to eql(@term2.label)
        expect(Term.find_by(position: 3).label).to eql(@term1.label)
        expect(Term.find_by(position: 4).label).to eql("Bottom Term")
      end

      it "updates an existing term" do
        put :update_terms,
            "term_" + @term1.id.to_s => "Edited term 1",
            "term_" + @term2.id.to_s => @term2.label, 
            :new_terms => [""]
        expect(Term.find_by label: "Edited term 1").to_not be_nil
      end

      it "deletes blank terms" do
        expect{ 
          put :update_terms,
              "term_" + @term1.id.to_s => "",
              "term_" + @term2.id.to_s => @term2.label,
              :new_terms => ["", "", "", "", ""] 
        }.to change(Term.where(label: "Term 1"), :count).by(-1)
      end

      it "reassigns jobs with deleted terms" do
        expect{ 
          put :update_terms,
              "term_" + @term1.id.to_s => "",
              "term_" + @term2.id.to_s => @term2.label,
              :new_terms => ["", "", "", "", ""] 
        }.to change(Job.where(term: @unspecified_term), :count).by(1) 
      end  

      it "deletes the unassigned term with no jobs" do
        expect{ 
          put :update_terms,
              "term_" + @unspecified_term.id.to_s => ""
        }.to change(Term.where(label: "Unspecified"), :count).by(-1)
      end

      it "fails to delete the unassigned term with jobs" do
        FactoryGirl.create(:job, term: @unspecified_term)
        expect{ 
          put :update_terms,
              "term_" + @unspecified_term.id.to_s => ""
        }.to change(Term.where(label: "Unspecified"), :count).by(0)
      end

      it "repositions terms" do
        put :update_terms,
            "term_" + @term1.id.to_s => @term1.label,
            "term_" + @term1.id.to_s + "_position" => "2",
            "term_" + @term2.id.to_s => @term2.label, 
            "term_" + @term2.id.to_s + "_position" => "1",
            :new_terms => [""]
        expect(Term.find_by(position: 1).id).to eql(@term2.id)
        expect(Term.find_by(position: 2).id).to eql(@term1.id)
      end

      it "raises a flash if two experiences are assigned the same position" do
        put :update_terms,
            "term_" + @term1.id.to_s => @term1.label,
            "term_" + @term1.id.to_s + "_position" => "3",
            "term_" + @term2.id.to_s => @term2.label, 
            "term_" + @term2.id.to_s + "_position" => "3",
            :new_terms => [""]
        expect(flash[:error]).to eql("Multiple terms can't have the same position.")
      end
        
      it "sends a flash" do
        put :update_terms
        expect(flash[:notice]).to eql("Terms saved.")
      end
    end
  end

  describe "DELETE destroy_term" do
    before(:each) do
      @term1 = FactoryGirl.create(:term, label: "Term 1")
      @term2 = FactoryGirl.create(:term, label: "Term 2")
      @experience1 = FactoryGirl.create(:experience, label: "Experience 1")
      @experience2 = FactoryGirl.create(:experience, label: "Experience 2")
      @unspecified_term = FactoryGirl.create(:term, label: "Unspecified")
      @job1 = FactoryGirl.create(:job, experience: @experience1, term: @term1)
    end

    context "when not logged in" do
      before(:each) do
        allow(controller).to receive_messages(:current_user => nil)
        delete :destroy_term, id: @term1.id
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
        delete :destroy_term, id: @term1.id
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
      end

      it "deletes the term" do
        expect{ delete :destroy_term, id: @term1.id }.to change( 
          Term.where(label: "Term 1"), :count).by(-1)
      end

      it "reassigns jobs with deleted terms" do
        expect{ delete :destroy_term, id: @term1.id }.to change(
          Job.where(term: @unspecified_term), :count).by(1) 
      end  

      it "deletes the unassigned term with no jobs" do
        expect{ delete :destroy_term, id: @unspecified_term.id }.to change( 
          Term.where(label: "Unspecified"), :count).by(-1)
      end

      it "fails to delete the unassigned term with jobs" do
        FactoryGirl.create(:job, term: @unspecified_term)
        expect{ delete :destroy_term, id: @unspecified_term.id }.to change( 
          Term.where(label: "Unspecified"), :count).by(0)
      end
    end
  end
end
