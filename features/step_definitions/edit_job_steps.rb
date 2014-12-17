When(/^he submits the edit job form$/) do
  fill_in('job_title', :with => 'Astronaut')
  click_button('Save job')
end

