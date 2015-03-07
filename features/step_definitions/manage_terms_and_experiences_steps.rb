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
end

When(/^he deletes a term$/) do
  find("input[id='delete_term_a']", visible: false).click
end

Given(/^a job with the unspecified experience exists$/) do
  @unspecified_exp = FactoryGirl.create(:experience, label: "Unspecified")
  FactoryGirl.create(:job, experience: @unspecified_exp)
end

When(/^he deletes the unspecified experience$/) do
  find("input[class='destroy_experience'][id='delete_unspecified']", visible: false).click
end

Given(/^a job with the unspecified term exists$/) do
  @unspecified_term = FactoryGirl.create(:term, label: "Unspecified")
  FactoryGirl.create(:job, term: @unspecified_term)
end

When(/^he deletes the unspecified term$/) do
  find("input[class='destroy_term'][id='delete_unspecified']", visible: false).click
end

Given(/^the unspecified experience exists$/) do
  FactoryGirl.create(:experience, label: "Unspecified")
end

Given(/^the unspecified term exists$/) do
  FactoryGirl.create(:term, label: "Unspecified")
end

