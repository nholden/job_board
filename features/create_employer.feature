Feature: Create employer
  As an employer
  In order to save my information
  I want to create an account

  Scenario: Create valid employer
    Given the user "ceo@boeing.com" does not have an account 
    When he submits the create employer form
    Then he should see "Created employer account."
