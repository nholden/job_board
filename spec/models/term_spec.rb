require 'rails_helper'

RSpec.describe Term, :type => :model do
  it "should have many jobs" do
    expect(Experience.reflect_on_association(:jobs).macro).to eq(:has_many)
  end
end
