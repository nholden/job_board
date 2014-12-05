When(/^he submits the login form$/) do
  visit('login')
  fill_in('session_email', :with => 'ceo@boeing.com')
  fill_in('session_password', :with => 'password')
  click_button('Login')
end

When(/^he submits the login form with bad credentials$/) do
  visit('login')
  fill_in('session_email', :with => 'ceo@boeing.com')
  fill_in('session_password', :with => 'notpassword')
  click_button('Login')
end

When(/^he visits the signup page$/) do
  visit('users/new')
end
