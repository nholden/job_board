Feature: Edit job
  As an employer
  In order to update an out-of-date job
  I want to edit a job

  Scenario: Successful edit
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    When he clicks "(Edit)"
    When he submits the edit job form
    Then he should not see "Aerospace engineer intern"
    Then he should see "Astronaut"

  Scenario: Not logged in
    Given the user is not logged in
    When he visits the jobs page
    Then he should not see "(Edit)"
