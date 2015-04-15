Feature: View users
  As an administrator
  So that I can see who has accounts on my job board
  I want to see a list of users

  Scenario: View users successfully
    Given the admin is logged in
    Given an employer exists
    When he visits the jobs page
    When he clicks "Manage users"
    Then he should see "Boeing"

  Scenario: Non-logged in user attempts to access manage users page
    Given the user is not logged in
    Given an employer exists
    When he visits the manage users page
    Then he should see "You must be logged in as an administrator to manage users."

  Scenario: Employer attempts to access manage users page
    Given an employer is logged in
    When he visits the manage users page
    Then he should see "You must be logged in as an administrator to manage users."

  Scenario: Applicant attempts to access manage users page
    Given an applicant is logged in
    When he visits the manage users page
    Then he should see "You must be logged in as an administrator to manage users."
