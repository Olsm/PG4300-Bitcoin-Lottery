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
  fill_in('#body', with: "Valid input")
end

Then(/^I should see notice "([^"]*)"$/) do |expected|
  assert_equal flash[:notice], expected
end

And(/^I should receive a confirmation email$/) do
  email = ActionMailer::Base.deliveries.first
  email.from.should == "admin@example.com"
  email.to.should == @user.email
  email.body.should include("Thank you for contacting Bitcoin Lottery")
end

When(/^I enter an invalid email, name and message$/) do
  fill_in('£body', with: "Invalid input")
end