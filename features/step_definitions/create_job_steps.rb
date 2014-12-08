When(/^he submits the create job form$/) do
  visit('/jobs/new')
  fill_in('job_title', :with => 'Aerospace engineer intern')
  select('Internship', :from => 'job_type')
  fill_in('location', :with => 'Seattle, WA')
  select('Some college', :from => 'job_experience')
  fill_in('majors', :with => 'Aero/Astro')
  fill_in('description', :with => 'This is a great position in which the
                                   intern will build some incredible stuff
                                   for the first manned flight to Mars')
  fill_in('url', :with => 'http://www.boeing.com/jobs/intern.php')
  fill_in('instructions', :with => 'Send an email to ceo@boeing.com')
  select('2016', :from => 'job_deadline_year')
  select('12', :from => 'job_deadline_month')
  select('01', :from => 'job_deadline_day')
  fill_in('salary', :with => '$20/hour')
  click_button('Create job')
end
