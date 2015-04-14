Feature: Login employer
  As an employer
  So that I can post and update things
  I want to login

  Scenario: Login successfully
    Given the user is not logged in
    When he submits the create employer form
    When he logs out
    When he submits the login form
    Then he should see "Logged in successfully." 
    Then he should see "Log out"
    Then he should see "Post new job"

  Scenario: Fail to login
    Given the user is not logged in
    When he submits the create employer form
    When he logs out
    When he submits the login form with bad credentials
    Then he should see "Email and password combination not recognized."
    When he visits the signup employer page
    Then he should not see "Email and password combination not recognized."
    Then he should not see "Log out"
    Then he should not see "Post new job"

  Scenario: Already logged in
    Given the user is logged in
    When he visits the login form
    Then he should see "Already logged in."

  Scenario: Logout successfully
    Given the user is logged in
    When he visits the jobs page
    When he clicks "Log out"
    Then he should see "Logged out successfully."
    Then he should see "Log in"
    Then he should not see "Post new job"
