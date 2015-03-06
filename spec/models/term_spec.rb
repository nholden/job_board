require 'rails_helper'

RSpec.describe Term, :type => :model do
  it "should have many jobs" do
    expect(Experience.reflect_on_association(:jobs).macro).to eq(:has_many)
  end

  describe "destroy_and_reassign_jobs" do
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
end
