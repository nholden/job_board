require 'rails_helper'

RSpec.describe Job, :type => :model do
  it "is invalid without a title" do
    expect(FactoryGirl.build(:job, title: nil)).to_not be_valid
  end

  it "is invalid without a location" do
    expect(FactoryGirl.build(:job, location: nil)).to_not be_valid
  end

  it "is invalid without a description" do
    expect(FactoryGirl.build(:job, description: nil)).to_not be_valid
  end

  it "is invalid without a user" do
    expect(FactoryGirl.build(:job, user: nil)).to_not be_valid
  end

  it "is invalid without an experience" do
    expect(FactoryGirl.build(:job, experience: nil)).to_not be_valid
  end

  it "is invalid without a term" do
    expect(FactoryGirl.build(:job, term: nil)).to_not be_valid
  end

  it "should belong_to experience" do
    expect(Job.reflect_on_association(:experience).macro).to eq(:belongs_to)
  end

  it "should belong_to term" do
    expect(Job.reflect_on_association(:term).macro).to eq(:belongs_to)
  end

  subject { FactoryGirl.create(:job) }
  its(:title) { should == 'Aerospace engineer intern' }
end
