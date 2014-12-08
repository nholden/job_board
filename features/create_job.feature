Feature: Post a job
  As an employer
  So that prospects will see my job
  I want to post a job listing

  Scenario: Successful posting
    Given the user is logged in   
    When he submits the create job form
    Then he should see "Created job."
