When(/^he clicks the edit button for Boeing$/) do
  user_id = User.find_by_name('Boeing').id
  find(:xpath, "//a[@href='/users/#{user_id}/edit']").click
end
