require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { FactoryGirl.create(:user) }
  its(:name) { should == 'Boeing' }

  it "should belong_to role" do
    expect(User.reflect_on_association(:role).macro).to eq(:belongs_to)
  end

  it "should have many applications" do
    expect(User.reflect_on_association(:applications).macro).to eq(:has_many)
  end

  it "should respond to resume" do
    expect(FactoryGirl.build(:user)).to respond_to(:resume)
  end

  it "is invalid without a role" do
    expect(FactoryGirl.build(:user, role: nil)).to_not be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:user, name: nil)).to be_invalid
  end

  it "is valid without a website" do
    expect(FactoryGirl.build(:user, website: nil)).to be_valid
  end
end
