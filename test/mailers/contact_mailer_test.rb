require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "contact_confirmation" do
    contact = Contact.new(:name => "suchName", :email => "such@mail.wow", :message => "Very message")
    mail = ContactMailer.contact_confirmation contact
    assert_equal "Bitcoin Lottery Contact Confirmation", mail.subject
    assert_equal ["such@mail.wow"], mail.to
    assert_equal ["bitcoinlottery@immortaltools.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
