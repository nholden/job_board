Feature: Order terms and experiences
  As an administrator
  In order to show terms and experiences in specific orders
  I would like to order terms and experiences

  Scenario: Experience order dropdowns populated with position
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then "1" should be selected in the "experience_1" dropdown
    Then "2" should be selected in the "experience_2" dropdown

  Scenario: Successfully order experience
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then the first experience should be "experience_1"
    When he moves "experience_2" to the top experience
    When he saves experiences
    Then the first experience should be "experience_2"

  Scenario: Prevent selecting same position for two experiences
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "experience_1" to position "3"
    When he moves "experience_2" to position "3"
    When he saves experiences
    Then he should see "Multiple experiences can't have the same position"
