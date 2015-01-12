When(/^he filters for full time jobs$/) do
  visit('/')
  select('Full time permanent', :from => 'term')
  click_button('Filter')
end

