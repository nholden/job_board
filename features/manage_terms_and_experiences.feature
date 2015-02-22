Feature: Manage terms and experiences
  As an administrator
  So that I can give employers different options for terms and experiences
  I would like to manage the terms and experiences

  Scenario: Add an experience
    Given the admin is logged in
    When he clicks "Settings"
    When he adds an experience
    Then he should see a textbox filled in with "Experience 3"

  Scenario: Add a term
    Given the admin is logged in
    When he clicks "Settings"
    When he adds a term
    Then he should see a textbox filled in with "Term 3"
