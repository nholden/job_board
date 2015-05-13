Feature: Create applicant
  As an applicant
  In order to save my information
  I want to sign up

  Scenario: Successful signup
    Given an administrator exists
    Given the user is not logged in
    When he visits the jobs page
    When he clicks "Sign up"
    When he clicks "Applicant"
    When he fills in the signup applicant form
    Then he should see "Created applicant account"
    Then he should see "Log out"
    Then he should not see "Post new job"

  Scenario: Fail to signup with no name
    Given an administrator exists
    Given the user is not logged in
    When he visits the jobs page
    When he clicks "Sign up"
    When he clicks "Applicant"
    When he fills in the signup applicant form with no name
    Then he should see "Name can't be blank"
