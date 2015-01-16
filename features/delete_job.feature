Feature: Delete job
  As an employer
  So that I can remove filled jobs
  I want to delete a job

  Scenario: Successful delete
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see "Aerospace engineer intern"
    When he clicks "Delete"
    Then he should not see "Aerospace engineer intern"

  Scenario: Not logged in
    Given the user is not logged in
    When he visits the jobs page
    Then he should not see "Delete"
