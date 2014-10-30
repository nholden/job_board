Given(/^the user is not logged in$/) do
  expect(@current_user).to be_nil
end

When(/^he submits the create employer form$/) do
  visit('/employers/new')
  fill_in('Email', :with => 'ceo@boeing.com')
  fill_in('Password', :with => 'password')
  fill_in('Confirm', :with => 'password')
  fill_in('Company name', :with => 'Boeing')
  fill_in('Company description', :with => 'Aerospace company')
  fill_in('Company website', :with => 'http://www.boeing.com')
  click_button('Create account')
end

Then(/^he should see "(.*?)"$/) do |text|
  page.should have_content(text)
end

