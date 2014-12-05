Feature: Login employer
  As an employer
  So that I can post and update things
  I want to login

  Scenario: Login successfully
    Given the user is not logged in
    When he submits the login form
    Then he should see "Logged in successfully." 
