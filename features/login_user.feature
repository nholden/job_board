Feature: Login employer
  As an employer
  So that I can post and update things
  I want to login

  Scenario: Login successfully
    Given the user is not logged in
    When he submits the create employer form
    When he submits the login form
    Then he should see "Logged in successfully." 
    Then he should see "Log out"

  Scenario: Fail to login
    Given the user is not logged in
    When he submits the create employer form
    When he submits the login form with bad credentials
    Then he should see "Email and password combination not recognized."
    When he visits the signup page
    Then he should not see "Email and password combination not recognized."

  Scenario: Logout successfully
    Given the user is logged in
    When he visits the jobs page
    When he clicks "Log out"
    Then he should see "Logged out successfully."
    Then he should see "Log in"
