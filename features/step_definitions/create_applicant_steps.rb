When(/^he fills in the signup applicant form$/) do
  visit('/signup-applicant')
  fill_in('user_email', :with => 'job@seeker.net')
  fill_in('user_password', :with => 'password1')
  fill_in('user_password_confirmation', :with => 'password1')
  click_button('Create account')
end
