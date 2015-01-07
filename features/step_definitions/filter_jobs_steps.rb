When(/^he filters for full time jobs$/) do
  visit('/')
  select('Full time permanent', :from => 'job_term')
  click_button('Filter jobs')
end

