When(/^he saves experiences$/) do
  click_button('Save experiences')
end

Then(/^the first experience should be "(.*?)"$/) do |experience|
  expect(
    page.first(:css, "form[action='/update_experiences']").
         first(:css, ".edit-option").first(:css, "input")[:id]
    ).to eql(experience)
end

When(/^he moves "(.*?)" to the top experience$/) do |experience|
  page.find(:css, "select[id='#{experience}_position']").find("option[value='0']").select_option
end

Then(/^"(.*?)" should be selected in the "(.*?)" dropdown$/) do |option, select|
  expect(
    page.find(:css, "select[id='#{select}_position']").value
    ).to eql(option)
end

When(/^he moves "(.*?)" to position "(.*?)"$/) do |experience, position|
  page.find(:css, "select[id='#{experience}_position']").find("option[value='#{position}']").select_option
end

When(/^he adds a new experience with position "(.*?)"$/) do |position|
  find("#new_experiences_", match: :first).set("Experience 3")
  page.find(:css, "select[id='new_experience_positions_']", match: :first).find("option[value='#{position}']").select_option
end

Then(/^the second experience should be "(.*?)"$/) do |experience|
  input_ids = page.first(:css, "form[action='/update_experiences']").
                     all(:css, ".edit-option input")
  expect(input_ids[1][:id]).to eql(experience)
end

Then(/^the third experience should be "(.*?)"$/) do |experience|
  input_ids = page.first(:css, "form[action='/update_experiences']").
                     all(:css, ".edit-option input")
  expect(input_ids[2][:id]).to eql(experience)
end
