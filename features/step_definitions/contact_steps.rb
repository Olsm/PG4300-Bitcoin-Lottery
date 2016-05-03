Given(/^I am on the contact us page$/) do
  visit '/contact'
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

And(/^I attach a file$/) do
  attach_file('attachment', 'features/file_uploads/test.jpg')
end

Then(/^the file will be uploaded$/) do
  pending
end

And(/^added as an attachment$/) do
  pending
end

When(/^I enter a valid email, name and message$/) do
  fill_in('contact_name', :with => "Such Name")
  fill_in('contact_email', :with => "very@mail.wow")
  fill_in('contact_message', :with => "Much message!")
end

Then(/^I should see notice "([^"]*)"$/) do |expected|
  assert page.has_content? expected
end

And(/^Bitcoin lottery should get my submission$/) do
  email = ActionMailer::Base.deliveries.first
  assert_equal ["very@mail.wow"], email.from
  assert_equal ["admin@example.com"], email.to
  assert_match /Bitcoin Lottery Contact Submission/, email.body.raw_source
  assert_match /very@mail.wow/, email.body.raw_source
  assert_match /Much message!/, email.body.raw_source
end

And(/^I should receive a confirmation email$/) do
  email = ActionMailer::Base.deliveries[1]
  assert_equal ["admin@example.com"], email.from
  assert_equal ["very@mail.wow"], email.to.should
  assert_match /Thank you for contacting Bitcoin Lottery/, email.body.raw_source
end

When(/^I enter an invalid email, name and message$/) do
  fill_in('contact_name', :with => "Such N@me")
  fill_in('contact_email', :with => "so.invalid.mail")
  fill_in('contact_message', :with => "Much me$$age!")
end