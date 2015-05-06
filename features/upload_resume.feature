Feature: Upload resume
  As an applicant
  In order to show employers by background
  I would like to upload a resume

  Scenario: Successful upload
    Given an applicant is logged in
    When he visits the jobs page
    When he clicks "Edit profile"
    When he uploads a resume
    When he clicks the "Update account" button
    Then he should see "Updated profile"
    When he clicks "Edit profile"
    Then he should see "Example_Resume_v01.pdf"

  Scenario: Successful delete
    Given an applicant is logged in
    When he visits the jobs page
    When he clicks "Edit profile"
    When he uploads a resume
    When he clicks the "Update account" button
    When he clicks "Edit profile"
    Then he should see "Example_Resume_v01.pdf"
    When he clicks the "Delete resume" icon 
    When he clicks the "Update account" button
    When he clicks "Edit profile"
    Then he should not see "Example_Resume_v01.pdf"
