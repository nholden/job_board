require 'rails_helper'

RSpec.describe Application, :type => :model do
  it "should belong_to user" do
    expect(Application.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it "should belong_to job" do
    expect(Application.reflect_on_association(:job).macro).to eq(:belongs_to)
  end

  it "should have a default status of 'Submitted'" do
    @applicant = FactoryGirl.create(:applicant)
    @application = FactoryGirl.create(:application, user_id: @applicant.id, status: nil)
    expect(@application.status).to eql("Submitted")
  end

  it "should not be valid with users that are not applicants" do
    @admin = FactoryGirl.create(:admin)
    expect(FactoryGirl.build(:application, user_id: @admin.id)).to_not be_valid
  end
end
