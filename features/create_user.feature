Feature: Create employer
  As an employer
  In order to save my information
  I want to create an account

  Scenario: Create valid employer
    Given the user is not logged in 
    When he submits the create employer form
    Then he should see "Created employer account."

  Scenario: Attempt to create employer without valid password confirmation
    Given the user is not logged in
    When he submits the create employer form without valid password confirmation
    Then he should see "Password confirmation doesn't match" 