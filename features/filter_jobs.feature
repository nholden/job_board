Feature: Filter jobs
  As a prospect
  In order to see only jobs that are relevant for me
  I want to filer jobs

  Scenario: Successful filter
    Given the user is logged in
    When he submits the create job form
    Then he should see "Aerospace engineer intern"
    When he filters for full time jobs
    Then he should not see "Aerospace engineer intern"
