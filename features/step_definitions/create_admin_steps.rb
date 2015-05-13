Given(/^there is no admin$/) do
  expect(Role.find_or_create_by(label: 'employer').users.count).to eql(0)
end

Given(/^the admin is logged in$/) do
  @admin = User.new(:email    => "admin@jobboard.com",
                   :password => "admin",
                   :name     => "Admin",
                   :website  => "www.jobboard.com",
                   :role_id  => Role.find_or_create_by(label: 'admin').id)
  @admin.save
  visit('login')
  fill_in('session_email', :with => 'admin@jobboard.com')
  fill_in('session_password', :with => 'admin')
  click_button('Login')
end

When(/^he fills out the create new user form for an admin$/) do
  fill_in('user_name', :with => 'Second admin')
  fill_in('user_email', :with => 'secondadmin@admin.com')
  fill_in('user_password', :with => 'password')
  fill_in('user_password_confirmation', :with => 'password')
  click_button('Create account')
end

When(/^he fills out the create new user form for an employer$/) do
  fill_in('user_email', :with => 'ceo@raytheon.com')
  fill_in('user_password', :with => 'password')
  fill_in('user_password_confirmation', :with => 'password')
  fill_in('user_name', :with => 'Raytheon')
  fill_in('user_website', :with => 'http://www.raytheon.com')
  click_button('Create account')
end

Given(/^admin and employer roles exist$/) do
  FactoryGirl.create(:role, label: 'admin')
  FactoryGirl.create(:role, label: 'employer')
end
