When(/^he fills in the signup applicant form$/) do
  visit('/signup-applicant')
  fill_in('user_email', :with => 'job@seeker.net')
  fill_in('user_password', :with => 'password1')
  fill_in('user_password_confirmation', :with => 'password1')
  select('applicant', :from => 'user_role_id')
  click_button('Create account')
end

Then(/^"(.*?)" should be selected in the "(.*?)" dropdown$/) do |option, id|
  expect(page.find(:css, "select[id='#{id}']").find('option[selected]').text).to eql(option)
end
