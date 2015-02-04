Given(/^I enter a player's email address$/) do
  page.fill_in("Invite player", with: "bob@example.com")
end

When(/^I click the Invite Player button$/) do
  click_button "Invite Player"
end

Then(/^I see the player's email in the list$/) do
  expect(page.find("ul")).to have_content "bob@example.com"
end

And(/^the player is listed as not joined$/) do
  expect(page.find("ul")).to have_content "not joined"
end

And(/^the player has received an email invitation$/) do
  expect(Pony).to have_received(:mail).with(to: "bob@example.com")
end
