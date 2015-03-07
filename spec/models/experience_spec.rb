require 'rails_helper'

RSpec.describe Experience, :type => :model do
  it "should have many jobs" do
    expect(Experience.reflect_on_association(:jobs).macro).to eq(:has_many)
  end

  describe "destroy_and_reassign_jobs" do
    context "on a specified experience" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_jobs)
        @user.jobs.first.experience.destroy_and_reassign_jobs
      end

      it "destroys the experience" do
        expect(Experience.find_by(label: "Experience")).to be_nil
      end

      it "reassigns the the jobs' experience" do
        expect(@user.jobs.first.experience.label).to eql("Unspecified")
      end
    end

    context "on an unspecified experience with no jobs" do
      before(:each) do
        @experience = FactoryGirl.create(:experience, label: "Unspecified")
        @experience.destroy_and_reassign_jobs
      end

      it "destroys the experience" do
        expect(Experience.find_by(label: "Unspecified")).to be_nil
      end
    end

    context "on an unspecified experience with jobs" do
      before(:each) do
        @experience = FactoryGirl.create(:experience, label: "Unspecified")
        @job = FactoryGirl.create(:job, experience: @experience)
        @experience.destroy_and_reassign_jobs
      end

      it "does not destroy the experience" do
        expect(Experience.find_by(label: "Unspecified")).to_not be_nil
      end
    end
  end
end
