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

  Scenario: Successfully order exisiting experience
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then the first "experience" should be "experience_1"
    When he moves "experience_2" to the top
    When he saves "experiences"
    Then the first "experience" should be "experience_2"

  Scenario: Prevent selecting same position for two experiences
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "experience_1" to position "3"
    When he moves "experience_2" to position "3"
    When he saves "experiences"
    Then he should see "Multiple experiences can't have the same position"

  Scenario: Successfully order new experience
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "experience_1" to position "3"
    When he moves "experience_2" to position "1"
    When he adds a new "experience" with position "2"
    When he saves "experiences"
    Then the first "experience" should be "experience_2"
    Then the second "experience" should be "experience_3"
    Then the third "experience" should be "experience_1"

  Scenario: Successfully update positions after experience deleted
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he deletes an experience
    Then "1" should be selected in the "experience_2" dropdown

  Scenario: Term order dropdowns populated with position
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then "1" should be selected in the "term_1" dropdown
    Then "2" should be selected in the "term_2" dropdown

  Scenario: Successfully order exisiting term 
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then the first "term" should be "term_1"
    When he moves "term_2" to the top
    When he saves "terms"
    Then the first "term" should be "term_2"

  Scenario: Prevent selecting same position for two terms
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "term_1" to position "3"
    When he moves "term_2" to position "3"
    When he saves "terms"
    Then he should see "Multiple terms can't have the same position"

  Scenario: Successfully order new term
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "term_1" to position "3"
    When he moves "term_2" to position "1"
    When he adds a new "term" with position "2"
    When he saves "terms"
    Then the first "term" should be "term_2"
    Then the second "term" should be "term_3"
    Then the third "term" should be "term_1"

  Scenario: Successfully update positions after term deleted
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he deletes a term
    Then "1" should be selected in the "term_2" dropdown
