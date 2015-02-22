When(/^he adds a term$/) do
  find("#new_term", match: :first).set("Term 3")
  click_button('Save')
end
