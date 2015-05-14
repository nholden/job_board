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

  Scenario: View applications
    Given an applicant is logged in
    Given a job exists
    When he visits the jobs page
    When he clicks "Applications"
    Then he should not see "Aerospace engineer intern"
    When he visits the jobs page
    When he clicks "Aerospace engineer intern"
    When he clicks the "Apply" button
    When he clicks "Applications"
    Then he should see "Aerospace engineer intern"
    When he clicks "Aerospace engineer intern"
    Then he should see "Location: Seattle, WA"

  Scenario: View applications when no applications
    Given an applicant is logged in
    Given a job exists
    When he clicks "Applications"
    Then he should see "No active applications"

  Scenario: Not logged in
    Given a job exists
    When he visits the jobs page
    When he clicks "Aerospace engineer intern"
    Then he should see "Sign up or log in to apply."

  Scenario: Logged in as an employer
    Given an employer is logged in
    Given a job exists
    When he visits the jobs page
    When he clicks "Aerospace engineer intern"
    Then he should not see "Apply"
    Then he should not see "Sign up or log in to apply."
