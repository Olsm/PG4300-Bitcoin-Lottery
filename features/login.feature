Feature: Log-in
  Users can login to keep track of their lottery entries.
  They can chose to login with social media.

  Scenario: Valid credentials(normal privileges)
    Given I am in the login page
    When I enter valid credentials
    Then I expect to be logged in to my accoun

  Scenario: Valid credentials(Admin privileges)
    Given I am in the login page
    When I put in valid administrator credentials
    Then I expect to see the admin panel
     And I can manage the site with elevated privilege

  Scenario: Invalid credentials(any)
    Given I am in the login page
    When I put in invalid credentials
    Then I expect to see an error message/not be able to login