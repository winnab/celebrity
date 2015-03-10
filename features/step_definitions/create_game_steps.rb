Given(/^I am on the homepage$/) do
  visit "/"
  click_link "// Clear Session"
end

When(/^I input my name$/) do
  fill_in("creator_name", :with => "Winna")
end

And(/^I input my email$/) do
  fill_in("creator_email", :with => "test@example.com")
end

And(/^I input 5 email addresses$/) do
  fill_in("friend_1", :with => "friend_1@example.com")
  fill_in("friend_2", :with => "friend_2@example.com")
  fill_in("friend_3", :with => "friend_3@example.com")
  fill_in("friend_4", :with => "friend_4@example.com")
  fill_in("friend_5", :with => "friend_5@example.com")
end

When(/^I click the Create Game button$/) do
  click_button "Create Game"
end

Then(/^I see the new game with my name and the email addresses$/) do
  expect(page.find(".joined-players")).to have_content "Winna"
  expect(page.find(".invite-recipients")).to have_content "friend_2@example"
end
