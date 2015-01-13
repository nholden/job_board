When(/^he filters for full time jobs$/) do
  visit('/')
  select('Full time permanent', :from => 'q_term_eq')
  click_button('Search')
end

