Feature: Order terms and experiences
  As an administrator
  In order to show terms and experiences in specific orders
  I would like to order terms and experiences

  Scenario: Experience order dropdowns populated with position
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then "1" should be selected in the "Experience A" "experience" position dropdown
    Then "2" should be selected in the "Experience B" "experience" position dropdown

  Scenario: Successfully order exisiting experience
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then the first "experience" should be "Experience A"
    When he moves "Experience B" to the top "experience"
    When he saves "experiences"
    Then the first "experience" should be "Experience B"

  Scenario: Prevent selecting same position for two experiences
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "Experience A" to "experience" position "3"
    When he moves "Experience B" to "experience" position "3"
    When he saves "experiences"
    Then he should see "Multiple experiences can't have the same position"

  Scenario: Successfully order new experience
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "Experience A" to "experience" position "3"
    When he moves "Experience B" to "experience" position "1"
    When he adds a new "experience" with position "2"
    When he saves "experiences"
    Then the first "experience" should be "Experience B"
    Then the second "experience" should be "Experience C"
    Then the third "experience" should be "Experience A"

  Scenario: Successfully update positions after experience deleted
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he deletes an experience
    Then "1" should be selected in the "Experience B" "experience" position dropdown

  Scenario: Term order dropdowns populated with position
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then "1" should be selected in the "Term A" "term" position dropdown
    Then "2" should be selected in the "Term B" "term" position dropdown

  Scenario: Successfully order exisiting term 
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    Then the first "term" should be "Term A"
    When he moves "Term B" to the top "term"
    When he saves "terms"
    Then the first "term" should be "Term B"

  Scenario: Prevent selecting same position for two terms
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "Term A" to "term" position "3"
    When he moves "Term B" to "term" position "3"
    When he saves "terms"
    Then he should see "Multiple terms can't have the same position"

  Scenario: Successfully order new term
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he moves "Term A" to "term" position "3"
    When he moves "Term B" to "term" position "1"
    When he adds a new "term" with position "2"
    When he saves "terms"
    Then the first "term" should be "Term B"
    Then the second "term" should be "Term C"
    Then the third "term" should be "Term A"

  Scenario: Successfully update positions after term deleted
    Given job terms and experiences exist
    Given the admin is logged in
    When he clicks "Settings"
    When he deletes a term
    Then "1" should be selected in the "Term B" "term" position dropdown
