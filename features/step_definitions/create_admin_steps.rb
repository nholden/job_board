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

