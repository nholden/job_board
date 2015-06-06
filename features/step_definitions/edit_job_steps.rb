When(/^he submits the edit job form$/) do
  fill_in('job_title', :with => 'Astronaut')
  click_button('Save job')
end

Then(/^he should not see the edit icon$/) do
  page.should_not have_css('.fa-pencil')
end
