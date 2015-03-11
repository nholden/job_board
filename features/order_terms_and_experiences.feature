Feature: Order terms and experiences
  As an administrator
  In order to show terms and experiences in specific orders
  I would like to order terms and experiences

  Scenario: Successfully order experience
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then the first experience should be "Experience A"
    When he moves "Experience B" to the top experience
    When he saves experiences
    Then the first experience should be "Experience B"
