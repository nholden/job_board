When(/^he adds a term$/) do
  fill_in('term_label', :with => 'Term 3')
  click_button('Save')
end
