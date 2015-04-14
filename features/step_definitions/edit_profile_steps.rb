When(/^he submits the edit user form$/) do
  fill_in('user_name', :with => 'Lockheed Martin')
  click_button('Update account')
end

When(/^he submits the edit user form with mismatched passwords$/) do
  fill_in('user_name', :with => 'Lockheed Martin')
  fill_in('user_password', :with => 'password')
  fill_in('user_password_confirmation', :with => 'loremipsum')
  click_button('Update account')
end

