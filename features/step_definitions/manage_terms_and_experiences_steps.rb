When(/^he adds a term$/) do
  click_link('Add term')
  fill_in('new_term', :with => 'Term 3')
  click_button('Save')
end
