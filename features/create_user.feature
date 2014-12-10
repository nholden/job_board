Feature: Create user
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

  Scenario: Already logged in
    Given the user is logged in
    When he visits the create employer page
    Then he should see "Already logged in."
