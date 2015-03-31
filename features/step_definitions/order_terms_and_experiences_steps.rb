When(/^he saves "(.*?)"$/) do |managed|
  click_button("Save #{managed}")
end

Then(/^the first "(.*?)" should be "(.*?)"$/) do |managed, label|
  id = Object.const_get(managed.capitalize).find_by(label: label).id
  expect(
    page.first(:css, "form[action='/update_#{managed}s']").
         first(:css, ".edit-option").first(:css, "input")[:id]
    ).to eql("#{managed}_#{id}")
end

When(/^he moves "(.*?)" to the top "(.*?)"$/) do |label, managed|
  id = Object.const_get(managed.capitalize).find_by(label: label).id
  page.find(:css, "select[id='#{managed}_#{id}_position']").find("option[value='0']").select_option
end

Then(/^"(.*?)" should be selected in the "(.*?)" "(.*?)" position dropdown$/) do |option, label, managed|
  id = Object.const_get(managed.capitalize).find_by(label: label).id
  expect(
    page.find(:css, "select[id='#{managed}_#{id}_position']").value
    ).to eql(option)
end

When(/^he moves "(.*?)" to "(.*?)" position "(.*?)"$/) do |label, managed, position|
  id = Object.const_get(managed.capitalize).find_by(label: label).id
  page.find(:css, "select[id='#{managed}_#{id}_position']").find("option[value='#{position}']").select_option
end

When(/^he adds a new "(.*?)" with position "(.*?)"$/) do |managed, position|
  find("#new_#{managed}s_", match: :first).set("#{managed.capitalize} C")
  page.find(:css, "select[id='new_#{managed}_positions_']", match: :first).find("option[value='#{position}']").select_option
end

Then(/^the second "(.*?)" should be "(.*?)"$/) do |managed, label|
  id = Object.const_get(managed.capitalize).find_by(label: label).id
  input_ids = page.first(:css, "form[action='/update_#{managed}s']").
                     all(:css, ".edit-option input")
  expect(input_ids[1][:id]).to eql("#{managed}_#{id}")
end

Then(/^the third "(.*?)" should be "(.*?)"$/) do |managed, label|
  id = Object.const_get(managed.capitalize).find_by(label: label).id
  input_ids = page.first(:css, "form[action='/update_#{managed}s']").
                     all(:css, ".edit-option input")
  expect(input_ids[2][:id]).to eql("#{managed}_#{id}")
end
