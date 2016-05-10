class ContactMailer < ApplicationMailer
  def contact_confirmation contact
    @greeting = "Hi #{contact.name}"
    mail to: contact.email, subject: "Bitcoin Lottery Contact Confirmation"
  end
end
