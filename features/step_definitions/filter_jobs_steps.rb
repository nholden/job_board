When(/^he removes all filters$/) do
  select('', :from => 'q_term_id_eq')
  select('', :from => 'q_experience_id_eq')
  click_button('Search')
end

When(/^he filters for another job term$/) do
  visit('/')
  select('Term B', :from => 'q_term_id_eq')
  click_button('Search')
end

When(/^he filters for another job experience$/) do
  visit('/')
  select('Experience B', :from => 'q_experience_id_eq')
  click_button('Search')
end

When(/^he filters for the job term and experience$/) do
  visit('/')
  select('Term A', :from => 'q_term_id_eq')
  select('Experience A', :from => 'q_experience_id_eq')
  click_button('Search')
end
