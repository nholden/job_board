Feature: Edit employer profile (admin)
  As an administrator 
  In order to keep employer profiles accurate
  I want to edit an employer profile

  Scenario: Successful profile edit
    Given the admin is logged in
    Given a job exists
    When he visits the manage users page
    When he clicks the edit button for Boeing
    When he submits the edit user form
    Then he should not see "Boeing"
    Then he should see "Lockheed Martin"
