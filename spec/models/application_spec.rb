require 'rails_helper'

RSpec.describe Application, :type => :model do
  it "should belong_to user" do
    expect(Application.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it "should belong_to job" do
    expect(Application.reflect_on_association(:job).macro).to eq(:belongs_to)
  end
end
