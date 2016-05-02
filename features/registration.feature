Feature: Registration
  Users can register to keep track of their lottery entries.
  They can choose to register with social media.
  Email will be sent to user to confirm registration

  Scenario: Valid credentials
    Given I am in the registration page
     When I enter valid email and password
     Then I expect to get a confirmation email
      And I will be logged in to my account
      And be able to log in to my account
  Scenario: Registration with social media
    Given I am in the login page
     When I choose google or facebook
      And login with my google or facebook account
      And I accept permission to use my account details
     Then I will be logged in with my registered email
      And I will receive an email with generated password

   Scenario: Invalid credentials
     Given I am in the registration page
     When I enter email or password that do not meet the criteria
     Then I expect to get an error message
      And I will be prompted to enter valid credentials