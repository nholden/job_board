require 'rails_helper'

RSpec.describe Experience, :type => :model do
  it "should have many jobs" do
    expect(Experience.reflect_on_association(:jobs).macro).to eq(:has_many)
  end

  describe "destroy_and_reassign_jobs" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_jobs)
      @user.jobs.first.experience.destroy_and_reassign_jobs
    end

    it "destroys the experience" do
      expect(Experience.find_by(label: "Experience")).to be_nil
    end

    it "reassigns the the jobs' experience" do
      expect(@user.jobs.first.experience.label).to eql("Unassigned")
    end
  end
end
