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
  page.find(:css, "select[id='#{experience}_position']").find("option[value='0']").click
end

Then(/^"(.*?)" should be selected in the "(.*?)" dropdown$/) do |option, select|
  expect(
    page.find(:css, "select[id='#{select}_position']").value
    ).to eql(option)
end
