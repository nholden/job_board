Feature: View jobs
  Given I am a prospective job applicant
  So that I can learn about job openings
  I want to view jobs

  Scenario: Successfully view second page of jobs
    Given the user is not logged in
    Given 11 jobs exist
    When he visits the jobs page
    Then he should not see "Job #0"
    When he clicks "Next"
    Then he should see "Job #0"
