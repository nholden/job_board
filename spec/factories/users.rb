FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
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

  factory :admin, :class => 'User' do
    name "Job Board Guy"
    email "jobboardguy@jobboard.com"
    password "password"
    password_confirmation "password"
    description "The best place to post your jobs"
    website "http://www.jobboard.com"
    association :role, label: 'admin'
  end

  factory :applicant, :class => 'User' do
    name "Ima Jobseeker"
    email "applicant@jobseeker.net"
    password "applicantpassword"
    password_confirmation "applicantpassword"
    description nil
    website nil
    association :role, label: 'applicant'
  end
end
