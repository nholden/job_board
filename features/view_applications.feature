Feature: View applications
  As an employer
  So that I can identify applicants to hire
  I want to view applications for my jobs

  Scenario: Successfully view application
    Given an employer with a job and an application is logged in
    When he visits the jobs page
    When he clicks "View applications"
    When he clicks "applicant@applicant.com"
    Then he should see "Submitted"
