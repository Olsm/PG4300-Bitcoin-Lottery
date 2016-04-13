Feature: Contact
  Users can contact us through a contact us form
  To ask questions, give feedback, or report bugs
  They should be able to add an attachment

  Scenario: Add attachment
    Given that I am on the contact us page
     When I Chose to add attachment
      And I chose a file to upload
     Then the file will be uploaded
      And added as an attachment

Scenario: Submit contact form
    Given that I am on the contact us page
     When I enter a valid email, name and message
      And I submit the form
     Then I expect to receive a confirmation email of successful sending

Scenario: Submit contact form with invalid info
    Given that I am on the contact us page
     When I enter an invalid email, name and message
      And I submit the form
     Then I expect to receive an error message