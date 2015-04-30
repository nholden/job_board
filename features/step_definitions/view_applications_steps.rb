Given(/^an employer with a job and an application is logged in$/) do
  @employer = FactoryGirl.create(:user)
  @applicant = FactoryGirl.create(:applicant)
  @job = FactoryGirl.create(:job, user: @employer)
  @application = FactoryGirl.create(:application, user: @applicant, job: @job)
  visit('login')
  fill_in('session_email', with: @employer.email)
  fill_in('session_password', with: @employer.password)
  click_button('Login')
end
