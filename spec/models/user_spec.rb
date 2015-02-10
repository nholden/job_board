require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { FactoryGirl.create(:user) }
  its(:name) { should == 'Boeing' }

  it "should belong_to role" do
    expect(User.reflect_on_association(:role).macro).to eq(:belongs_to)
  end

  it "is invalid without a role" do
    expect(FactoryGirl.build(:user, role: nil)).to_not be_valid
  end
end
