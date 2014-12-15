FactoryGirl.define do
  factory :user do
    email "ceo@boeing.com"
    password "password"
    password_confirmation "password"
    name "Boeing"
    description "An aerospace company."
    website "http://www.boeing.com"

    factory :user_with_job do
      after(:create) do |user|
        create_list(:job, user: user)
      end
    end
  end
end
