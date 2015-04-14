When(/^he submits the login form$/) do
  visit('login')
  fill_in('session_email', :with => 'ceo@boeing.com')
  fill_in('session_password', :with => 'password')
  click_button('Login')
end

When(/^he visits the login form$/) do
  visit('login')
end

When(/^he submits the login form with bad credentials$/) do
  visit('login')
  fill_in('session_email', :with => 'ceo@boeing.com')
  fill_in('session_password', :with => 'notpassword')
  click_button('Login')
end

When(/^he visits the signup employer page$/) do
  visit('signup/employer')
end

Given(/^the user is logged in$/) do
  @user = User.new(:email    => "ceo@boeing.com",
                   :password => "password",
                   :name     => "Boeing",
                   :website  => "www.boeing.com",
                   :role_id  => Role.find_or_create_by(label: 'employer').id)
  @user.save
  visit('login')
  fill_in('session_email', :with => 'ceo@boeing.com')
  fill_in('session_password', :with => 'password')
  click_button('Login')
end

When(/^he visits the jobs page$/) do
  visit root_url
end

When(/^he clicks "(.*?)"$/) do |text|
  click_link(text)
end
