Given(/^(\d+) jobs exist$/) do |job_count|
  job_count.to_i.times do |n|
    FactoryGirl.create(:job, title: "Job ##{n}")
  end
end
