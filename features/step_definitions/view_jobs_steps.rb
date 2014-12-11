Given(/^there is an Aerospace Engineer Intern job posted$/) do
  @job = Job.new(FactoryGirl.attributes_for(:job))
  @job.save
end
