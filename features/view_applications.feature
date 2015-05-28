Feature: View applications
  As an employer
  So that I can identify applicants to hire
  I want to view profiles of applicants for my jobs

  Scenario: Successfully view applicant
    Given an employer with a job and an application is logged in
    When he visits the jobs page
    When he clicks "View applications"
    When he clicks "applicant@jobseeker.net"
    Then he should see "Email: applicant@jobseeker.net"

  Scenario: Successfully view applicant as an employer
    Given a job with an application exists
    Given the admin is logged in
    When he visits the jobs page
    When he clicks "View applications"
    When he clicks "applicant@jobseeker.net"
    Then he should see "Email: applicant@jobseeker.net"
