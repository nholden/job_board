Feature: Post a job
  As an employer
  So that prospects will see my job
  I want to post a job listing

  Scenario: Successful posting
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see "Created job."
    Then he should see "Aerospace engineer intern"
    Then he should see "Boeing"
    Then he should see "Experience A"

  Scenario: Not logged in
    Given the user is not logged in
    When he visits the create job page
    Then he should see "You must be logged in to create a job."
