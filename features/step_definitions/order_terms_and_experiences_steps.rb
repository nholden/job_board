When(/^he saves "(.*?)"$/) do |managed|
  click_button("Save #{managed}")
end

Then(/^the first "(.*?)" should be "(.*?)"$/) do |managed, id|
  expect(
    page.first(:css, "form[action='/update_#{managed}s']").
         first(:css, ".edit-option").first(:css, "input")[:id]
    ).to eql(id)
end

When(/^he moves "(.*?)" to the top$/) do |id|
  page.find(:css, "select[id='#{id}_position']").find("option[value='0']").select_option
end

Then(/^"(.*?)" should be selected in the "(.*?)" dropdown$/) do |option, select|
  expect(
    page.find(:css, "select[id='#{select}_position']").value
    ).to eql(option)
end

When(/^he moves "(.*?)" to position "(.*?)"$/) do |managed, position|
  page.find(:css, "select[id='#{managed}_position']").find("option[value='#{position}']").select_option
end

When(/^he adds a new "(.*?)" with position "(.*?)"$/) do |managed, position|
  find("#new_#{managed}s_", match: :first).set("#{managed.capitalize} 3")
  page.find(:css, "select[id='new_#{managed}_positions_']", match: :first).find("option[value='#{position}']").select_option
end

Then(/^the second "(.*?)" should be "(.*?)"$/) do |managed, id|
  input_ids = page.first(:css, "form[action='/update_#{managed}s']").
                     all(:css, ".edit-option input")
  expect(input_ids[1][:id]).to eql(id)
end

Then(/^the third "(.*?)" should be "(.*?)"$/) do |managed, id|
  input_ids = page.first(:css, "form[action='/update_#{managed}s']").
                     all(:css, ".edit-option input")
  expect(input_ids[2][:id]).to eql(id)
end
