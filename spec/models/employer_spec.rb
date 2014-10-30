require 'rails_helper'

RSpec.describe Employer, :type => :model do
  subject { FactoryGirl.create(:employer) }
  its(:name) { should == 'Boeing' }
end
