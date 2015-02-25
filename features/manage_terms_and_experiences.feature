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

  Scenario: Edit an experience
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    When he edits an experience
    Then he should not see a textbox filled in with "Experience 1"
    Then he should see a textbox filled in with "Edited experience 1"

  Scenario: Edit a term
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    When he edits a term
    Then he should not see a textbox filled in with "Term 1"
    Then he should see a textbox filled in with "Edited term 1"

  Scenario: Delete an experience
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    When he deletes an experience
    Then he should not see a textbox filled in with "Experience 1" 
    
  Scenario: Delete a term
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    When he deletes a term
    Then he should not see a textbox filled in with "Term 1"
