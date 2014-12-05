When(/^he submits the login form$/) do
  visit('login')
  fill_in('employer_email', :with => 'ceo@boeing.com')
  fill_in('employer_password', :with => 'password')
  click_button('Login')
end

