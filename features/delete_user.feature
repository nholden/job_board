Feature: Delete an employer
  As an admin
  So that I can remove old employers
  I want to delete an employer

  Scenario: Succesful delete
    Given the admin is logged in
    Given a job exists
    When he visits the jobs page
    Then he should see "Aerospace engineer intern"
    When he visits the manage users page
    Then he should see "Boeing"
    When he clicks "(Delete)"
    Then he should not see "Boeing"
    When he visits the jobs page
    Then he should not see "Aerospace engineer intern"

  Scenario: Unauthorized delete
    Given the user is logged in
    When he tries to delete a user
    Then he should see "You must be logged in as an administrator to delete users."
