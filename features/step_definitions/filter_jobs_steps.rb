When(/^he filters for another job term$/) do
  visit('/')
  check('term_2')
  click_button('Filter')
end

When(/^he filters for another job experience$/) do
  visit('/')
  check('experience_2')
  click_button('Filter')
end

When(/^he filters for the job term and experience$/) do
  visit('/')
  check('term_1')
  check('experience_1')
  click_button('Filter')
end
