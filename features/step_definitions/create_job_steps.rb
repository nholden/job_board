When(/^he submits the create job form$/) do
  visit('/jobs/new')
  fill_in('job_title', :with => 'Aerospace engineer intern')
  select('Internship', :from => 'job_term')
  fill_in('job_location', :with => 'Seattle, WA')
  select('Some college', :from => 'job_experience')
  fill_in('job_majors', :with => 'Aero/Astro')
  fill_in('job_description', :with => 'This is a great position in which the
                                   intern will build some incredible stuff
                                   for the first manned flight to Mars')
  fill_in('job_url', :with => 'http://www.boeing.com/jobs/intern.php')
  fill_in('job_instructions', :with => 'Send an email to ceo@boeing.com')
  select('2016', :from => 'job_deadline_1i')
  select('December', :from => 'job_deadline_2i')
  select('1', :from => 'job_deadline_3i')
  fill_in('job_salary', :with => '$20/hour')
  click_button('Create job')
end

When(/^he visits the create job page$/) do
  visit('/jobs/new')
end

