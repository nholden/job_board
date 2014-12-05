require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { FactoryGirl.create(:user) }
  its(:name) { should == 'Boeing' }
end
