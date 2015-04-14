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
    Then he should see "Create new admin"

  Scenario: Create valid admin
    Given the user is not logged in
    Given there is no admin
    When he submits the create admin form
    Then he should see "Created admin account."
    Then he should see "Log out"
    Then he should see "Manage users"

  Scenario: Delete job
    Given the admin is logged in
    Given a job exists
    When he visits the jobs page
    Then he should see the job title
    When he clicks "Delete"
    Then he should not see the job title

  Scenario: Create additional admin
    Given the admin is logged in
    When he clicks "Manage users"
    Then he should not see "Second Admin"
    When he clicks "Create new admin"
    Then he should see "Create new admin"
    When he fills out the create new user form for an admin
    Then he should see "Created admin account."
    Then he should see "secondadmin@admin.com"

  Scenario: Create additional employer
    Given admin and employer roles exist
    Given the admin is logged in
    When he clicks "Manage users"
    Then he should not see "Raytheon"
    When he clicks "Create new employer"
    Then he should see "Create new employer"
    When he fills out the create new user form for an employer
    Then he should see "Created employer account."
    Then he should see "Raytheon"
