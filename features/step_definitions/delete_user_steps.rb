When(/^he tries to delete a user$/) do
  user_id = User.first.id
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :delete, "/users/#{user_id}", {}
  Capybara.current_driver = current_driver
end

When(/^he clicks the delete button for Boeing$/) do
  user_id = User.find_by_name('Boeing').id
  find(:xpath, "//a[@href='/users/#{user_id}']").click
end
