require 'rails_helper'

RSpec.describe Term, :type => :model do
  it "should have many jobs" do
    expect(Experience.reflect_on_association(:jobs).macro).to eq(:has_many)
  end

  describe "destroy_and_reassign_jobs" do
    context "on a specified term" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_jobs)
        @user.jobs.first.term.destroy_and_reassign_jobs
      end

      it "destroys the term" do
        expect(Term.find_by(label: "Term")).to be_nil
      end

      it "reassigns the the jobs' experience" do
        expect(@user.jobs.first.term.label).to eql("Unspecified")
      end
    end

    context "on an unspecified term with no jobs" do
      before(:each) do
        @unspecified_term = FactoryGirl.create(:term, label: "Unspecified")
        @unspecified_term.destroy_and_reassign_jobs
      end

      it "destroys the term" do
        expect(Term.find_by(label:"Unspecified")).to be_nil
      end
    end

    context "on an unspecified term with jobs" do
      before(:each) do
        @unspecified_term = FactoryGirl.create(:term, label: "Unspecified")
        FactoryGirl.create(:job, term: @unspecified_term)
        @unspecified_term.destroy_and_reassign_jobs
      end

      it "does not destroy the unspecified term" do
        expect(Term.find_by(label: "Unspecified")).to_not be_nil
      end
    end
  end
end
