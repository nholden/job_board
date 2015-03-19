require 'rails_helper'

RSpec.describe Experience, :type => :model do
  it "should have many jobs" do
    expect(Experience.reflect_on_association(:jobs).macro).to eq(:has_many)
  end

  it "should respond to label" do
    @experience = FactoryGirl.create(:experience)
    expect(@experience).to respond_to(:label)
  end

  it "should respond to position" do
    @experience = FactoryGirl.create(:experience)
    expect(@experience).to respond_to(:position)
  end

  it "must have a label" do
    @experience = FactoryGirl.build(:experience, label: nil)
    expect(@experience).to be_invalid
  end

  it "must be assigned a position" do
    @experience = FactoryGirl.create(:experience)
    expect(@experience.position).to_not be_nil
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

  describe "reposition" do
    before(:each) do
      @experience_1 = FactoryGirl.create(:experience, id: 1, position: 1)
      @experience_2 = FactoryGirl.create(:experience, id: 2, position: 2)
      @experience_3 = FactoryGirl.create(:experience, id: 3, position: 3)
    end

    it "repositions the experiences" do
      Experience.reposition({1=>3, 2=>1, 3=>2})
      expect(Experience.find(1).position).to eql(3)
      expect(Experience.find(2).position).to eql(1)
      expect(Experience.find(3).position).to eql(2)
    end

    it "assigns the lowest possible integers while maintaining order" do
      Experience.reposition({1=>9, 2=>4, 3=>7})
      expect(Experience.find(1).position).to eql(3)
      expect(Experience.find(2).position).to eql(1)
      expect(Experience.find(3).position).to eql(2)
    end
  end
end
