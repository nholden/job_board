When(/^he tries to delete a user$/) do
  user_id = User.first.id
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :delete, "/user/#{user_id}", {}
  Capybara.current_driver = current_driver
end
