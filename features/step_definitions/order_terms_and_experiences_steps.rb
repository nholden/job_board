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
  page.find(:css, "select[id='#{experience.squish.downcase.tr(" ","_")}_position']").find("option[value='0']").click
end

Then(/^"(.*?)" should be selected in the "(.*?)" dropdown$/) do |option, select|
  page.find(:css, "select[id='#{select.squish.downcase.tr(" ","_")}_position']").value.should eq(option)
#  expect(page).to have_select("#{select.squish.downcase.tr(' ','_')}_position", selected: option)
end
