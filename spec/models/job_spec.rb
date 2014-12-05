require 'rails_helper'

RSpec.describe Job, :type => :model do
  it "is invalid without a title" do
    expect(FactoryGirl.build(:job, title: nil)).to_not be_valid
  end

  it "is invalid with a non-provided type" do
    expect(FactoryGirl.build(:job, type: "Awesome job")).to_not be_valid
  end

  it "is invalid without a location" do
    expect(FactoryGirl.build(:job, location: nil)).to_not be_valid
  end

  it "is invalid with a non-provided experience" do
    expect(FactoryGirl.build(:job, experience: "100 years")).to_not be_valid
  end

  it "is invalid without a description" do
    expect(FactoryGirl.build(:job, description: nil)).to_not be_valid
  end

  subject { FactoryGirl.create(:job) }
  its(:title) { should == 'Aerospace engineer intern' }
end
