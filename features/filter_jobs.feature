Feature: Filter jobs
  As a prospect
  In order to see only jobs that are relevant for me
  I want to filer jobs

  Scenario: Successful filter for term
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see the job title
    When he filters for another job term
    Then he should not see the job title

  Scenario: Successful filter for experience
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see the job title
    When he filters for another job experience
    Then he should not see the job title

  Scenario: Successful filter for both term and experience
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see the job title
    When he filters for another job experience
    Then he should not see the job title
    When he filters for the job term and experience
    Then he should see the job title

  Scenario: Successfully remove filters
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see the job title
    When he filters for another job term
    Then he should not see the job title
    When he removes all filters
    Then he should see the job title
