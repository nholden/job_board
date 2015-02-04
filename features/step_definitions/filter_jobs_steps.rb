When(/^he filters for another job term$/) do
  visit('/')
  check('Term B')
  click_button('Filter')
end

When(/^he filters for another job experience$/) do
  visit('/')
  check('Experience B')
  click_button('Filter')
end

When(/^he filters for the job term and experience$/) do
  visit('/')
  check('Term A')
  check('Experience A')
  click_button('Filter')
end
