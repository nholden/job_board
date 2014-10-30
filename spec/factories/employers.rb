FactoryGirl.define do
  factory :employer do
    email "ceo@boeing.com"
    password_digest "password"
    name "Boeing"
    description "An aerospace company."
    website "http://www.boeing.com"
  end
end
