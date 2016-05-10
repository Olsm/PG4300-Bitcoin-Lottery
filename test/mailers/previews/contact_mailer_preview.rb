# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/contact_confirmation
  def contact_confirmation
    contact = Contact.new
    contact.name = "Such Name"
    contact.email = "very@test.wow"
    ContactMailer.contact_confirmation contact
  end

end
