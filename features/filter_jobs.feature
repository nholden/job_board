Feature: Filter jobs
  As a prospect
  In order to see only jobs that are relevant for me
  I want to filer jobs

  Scenario: Successful filter for term
    Given the user is logged in
    When he submits the create job form
    Then he should see "Aerospace engineer intern"
    When he filters for full time jobs
    Then he should not see "Aerospace engineer intern"

  Scenario: Successful filter for experience
    Given I still need to work on this feature

  Scenario: Successful filter for both term and experience
    Given I still need to work on this feature
