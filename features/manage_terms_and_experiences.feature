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
    Then he should not see a textbox filled in with "Experience A"
    Then he should see a textbox filled in with "Edited experience A"

  Scenario: Edit a term
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    When he edits a term
    Then he should not see a textbox filled in with "Term A"
    Then he should see a textbox filled in with "Edited term A"

  Scenario: Delete an experience
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    Then he should see a textbox filled in with "Experience A"
    When he deletes an experience
    Then he should not see a textbox filled in with "Experience A" 
    
  Scenario: Delete a term
    Given the admin is logged in
    Given job terms and experiences exist
    When he clicks "Settings"
    Then he should see a textbox filled in with "Term A"
    When he deletes a term
    Then he should not see a textbox filled in with "Term A"

  Scenario: View job with deleted experience
    Given the admin is logged in
    Given a job exists
    When he clicks "Settings"
    When he deletes an experience
    When he visits the jobs page
    Then he should not see "Experience A"
    Then he should see "Unspecified"

  Scenario: View job with deleted term
    Given the admin is logged in
    Given a job exists
    When he clicks "Settings"
    When he deletes a term 
    When he visits the jobs page
    Then he should not see "Term A"
    Then he should see "Unspecified"

  Scenario: Delete the unspecified experience
    Given the admin is logged in
    Given the unspecified experience exists
    When he clicks "Settings"
    When he deletes the unspecified experience
    When he visits the jobs page
    Then he should not see "Unspecified"

  Scenario: Fail to delete the unspecified experience
    Given the admin is logged in
    Given a job with the unspecified experience exists
    When he clicks "Settings"
    When he deletes the unspecified experience
    Then he should see "You must delete or reassign the jobs with unspecified experiences."

  Scenario: Delete the unspecified term
    Given the admin is logged in
    Given the unspecified term exists
    When he clicks "Settings"
    When he deletes the unspecified term
    When he visits the jobs page
    Then he should not see "Unspecified"

  Scenario: Fail to delete the unspecified term
    Given the admin is logged in
    Given a job with the unspecified term exists
    When he clicks "Settings"
    When he deletes the unspecified term
    Then he should see "You must delete or reassign the jobs with unspecified terms."
    
