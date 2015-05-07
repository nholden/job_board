Feature: Edit employer profile
  As an employer
  In order to keep my profile up-to-date for prospects
  I want to edit my profile

  Scenario: Successful edit
    Given the user is logged in
    Given job terms and experiences exist
    When he submits the create job form
    Then he should see "Boeing"
    When he clicks "Edit profile"
    When he submits the edit user form
    When he visits the jobs page
    Then he should not see "Boeing"
    Then he should see "Lockheed Martin"

  Scenario: Mismatched passwords
    Given the user is logged in
    Given job terms and experiences exist
    When he clicks "Edit profile"
    When he submits the edit user form with mismatched passwords
    Then he should see "Password confirmation doesn't match Password"
