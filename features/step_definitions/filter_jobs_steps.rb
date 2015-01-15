When(/^he filters for full time jobs$/) do
  visit('/')
  select('Full time permanent', :from => 'q_term_id_eq')
  click_button('Search')
end

When(/^he filters for graduate degree jobs$/) do
  visit('/')
  select('Graduate degree', :from => 'q_experience_id_eq')
  click_button('Search')
end

When(/^he filters for internships requiring some college$/) do
  visit('/')
  select('Internship', :from => 'q_term_id_eq')
  select('Some college', :from => 'q_experience_id_eq')
  click_button('Search')
end

When(/^he removes all filters$/) do
  select('', :from => 'q_term_id_eq')
  select('', :from => 'q_experience_id_eq')
  click_button('Search')
end
