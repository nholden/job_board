Feature: Create admin
  As a site owner
  In order to control my site's content
  I want to create an administrator account

  Scenario: Alert that there is no admin
    Given the user is not logged in
    Given there is no admin
    When he visits the jobs page
    Then he should see "This job board has no administrator. Please create an account."
    When he clicks "create an account"
    Then he should see "Create administrator profile"

  Scenario: Create valid admin
    Given the user is not logged in
    Given there is no admin
    When he submits the create user form
    Then he should see "Created administrator account."
    Then he should see "Log out"
    Then he should see "Manage users"

  Scenario: Delete job
    Given the admin is logged in
    Given a job exists
    When he visits the jobs page
    Then he should see the job title
    When he clicks "Delete"
    Then he should not see the job title
