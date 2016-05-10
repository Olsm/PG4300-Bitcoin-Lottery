Feature: Contact
  Users can contact us through a contact us form
  To ask questions, give feedback, or report bugs
  They should be able to add an attachment

  Scenario: Add attachment
    Given I am on the contact us page
     When I enter a valid email, name and message
      And I attach a file
      And I press "Submit"
     Then File should be attachment in the email

  Scenario: Submit contact form
    Given I am on the contact us page
     When I enter a valid email, name and message
      And I press "Submit"
     Then I should see notice "Thank you. We will respond as soon as possible"
      And Bitcoin lottery should get my submission
      And I should receive a confirmation email

  Scenario: Submit contact form with invalid info
    Given I am on the contact us page
     When I enter an invalid email, name and message
      And I press "Submit"
     Then I should see notice "is invalid"
      And I should see notice "can&#39;t be blank"