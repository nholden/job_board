Given(/^the user is not logged in$/) do
  expect(@current_user).to be_nil
end

When(/^he submits the create employer form$/) do
  visit('/employers/new')
  fill_in('employer_email', :with => 'ceo@boeing.com')
  fill_in('employer_password', :with => 'password')
  fill_in('employer_confirm', :with => 'password')
  fill_in('employer_name', :with => 'Boeing')
  fill_in('employer_description', :with => 'Aerospace company')
  fill_in('employer_website', :with => 'http://www.boeing.com')
  click_button('Create account')
end

Then(/^he should see "(.*?)"$/) do |text|
  page.should have_content(text)
end

