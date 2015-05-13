Given(/^an applicant is logged in$/) do
  @applicant = User.new(:name     => "Applicant",
                        :email    => "applicant@gmail.com",
                        :password => "applicant",
                        :role_id  => Role.find_or_create_by(label: 'applicant').id)
  @applicant.save
  visit('login')
  fill_in('session_email', :with => 'applicant@gmail.com')
  fill_in('session_password', :with => 'applicant')
  click_button('Login')
end

When(/^he fills in the signup applicant form$/) do
  visit('/signup/applicant')
  fill_in('user_name', :with => 'Johnny Jobseeker')
  fill_in('user_email', :with => 'job@seeker.net')
  fill_in('user_password', :with => 'password1')
  fill_in('user_password_confirmation', :with => 'password1')
  attach_file(:user_resume, File.join(Rails.root, 'features', 'files', 'Example_Resume_v01.pdf'))
  click_button('Create account')
end

When(/^he fills in the signup applicant form with no name$/) do
  visit('/signup/applicant')
  fill_in('user_email', :with => 'job@seeker.net')
  fill_in('user_password', :with => 'password1')
  fill_in('user_password_confirmation', :with => 'password1')
  attach_file(:user_resume, File.join(Rails.root, 'features', 'files', 'Example_Resume_v01.pdf'))
  click_button('Create account')
end

Then(/^"(.*?)" should be selected in the "(.*?)" dropdown$/) do |option, id|
  expect(page.find(:css, "select[id='#{id}']").find('option[selected]').text).to eql(option)
end
