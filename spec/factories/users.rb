FactoryGirl.define do
  factory :user do
    email "ceo@boeing.com"
    password "password"
    password_confirmation "password"
    name "Boeing"
    description "An aerospace company."
    website "http://www.boeing.com"
    role

    factory :user_with_jobs do
      transient do
        jobs_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:job, evaluator.jobs_count, user: user)
      end
    end
  end
end
