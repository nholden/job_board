When(/^he adds a term$/) do
  find("#new_terms_", match: :first).set("Term 3")
  click_button('Save terms')
end

When(/^he adds an experience$/) do
  find("#new_experiences_", match: :first).set("Experience 3")
  click_button('Save experiences')
end

When(/^he edits an experience$/) do
  find("input[value='Experience A']").set("Edited experience A")
  click_button('Save experiences')
end

When(/^he edits a term$/) do
  find("input[value='Term A']").set("Edited term A")
  click_button('Save terms')
end

When(/^he deletes an experience$/) do
  find("input[id='delete_experience_a']", visible: false).click
  click_button('Save experiences')
end

When(/^he deletes a term$/) do
  find("input[id='delete_term_a']", visible: false).click
  click_button('Save terms')
end