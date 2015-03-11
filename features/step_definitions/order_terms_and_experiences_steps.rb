When(/^he saves experiences$/) do
  click_button('Save experiences')
end

Then(/^the first experience should be "(.*?)"$/) do |experience|
  expect(
    page.first(:css, "form[action='/update_experiences']").
         first(:css, ".edit-option").first(:css, "input").value
    ).to eql(experience)
end

When(/^he moves "(.*?)" to the top experience$/) do |experience|
  page.find(:css, "input[id='#{experience.squish.downcase.tr(" ","_")}_position']").find('option["0"]').click
end

