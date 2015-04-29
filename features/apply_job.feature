Feature: Apply for a job
  As an applicant
  So that I can be hired
  I want to apply for a job

  Scenario: Successful application
    Given an applicant is logged in
    Given a job exists
    When he visits the jobs page
    When he clicks "Aerospace engineer intern"
    When he clicks the "Apply" button
    Then he should see "Application to 'Aerospace engineer intern' successfully submitted"

  Scenario: Not logged in
    Given a job exists
    When he visits the jobs page
    When he clicks "Aerospace engineer intern"
    Then he should see "Sign up or log in to apply."
