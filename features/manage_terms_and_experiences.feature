Feature: Manage terms and experiences
  As an administrator
  So that I can give employers different options for terms and experiences
  I would like to manage the terms and experiences

  Scenario: Add a term
    Given the admin is logged in
    When he clicks "Settings"
    When he adds a term
    Then he should see "Term 3"
