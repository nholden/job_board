Feature: Create employer
  As an employer
  In order to save my information
  I want to create an account

  Scenario: Create valid employer
    Given I am on the new employer page
    When I fill in "Email" with "ceo@boeing.com"
    And I fill in "Password" with "password"
    And I fill in "Confirm" with "confirm"
    And I fill in "Company name" with "Boeing"
    And I fill in "Company description" with
      """
      Boeing is the world's largest aerospace company and
      leading manufacturer of commmerical jetliners and defence,
      space and security systems.
      """
    And I fill in "Company website" with "http://www.boeing.com"
    And I press "Create"
    Then I should see "New account created"
    And I should see "Boeing"
    And I should see "Create new job"
