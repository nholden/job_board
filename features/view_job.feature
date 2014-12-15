Feature: View single job
  As a prospect
  So that I can see more details about a job
  I want to view a single job

  Scenario: Sucessfully view a job
    Given the user is logged in
    When he submits the create job form
    When he clicks "Aerospace engineer intern"
    Then he should see "This is a great position in which"
