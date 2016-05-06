require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "registration_confirmation" do
    user = users(:one)
    mail = UserMailer.registration_confirmation user
    assert_equal "Registration confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["bitcoinlottery@immortaltools.com"], mail.from
    assert_match "Your account has been registered", mail.body.encoded
  end

end
