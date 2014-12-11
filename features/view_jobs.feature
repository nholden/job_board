Feature: View all jobs
  As a prospect
  So that I can apply for a job
  I want to view all jobs

  Scenario: Successfully show jobs
    Given there is an Aerospace Engineer Intern job posted
    Given the user is not logged in
    When he visits the jobs page
    Then he should see "Aerospace engineer intern"
    Then he should see "Boeing"
