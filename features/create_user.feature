Feature: Create user
  As an employer
  In order to save my information
  I want to create an account

  Scenario: Create valid employer
    Given the user is not logged in 
    Given an administrator exists
    When he submits the create user form
    Then he should see "Created employer account."
    Then he should see "Log out"

  Scenario: Attempt to create employer without valid password confirmation
    Given the user is not logged in
    When he submits the create user form without valid password confirmation
    Then he should see "Password confirmation doesn't match" 

  Scenario: Already logged in
    Given the user is logged in
    When he visits the create user page
    Then he should see "Already logged in."
