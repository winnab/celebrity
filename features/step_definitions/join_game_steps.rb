Given(/^I have been invited to the game$/) do
  game_id = Capybara.app.settings.game_store.list.last.id
  new_invite = Invite.new({ name: "Sender", email: "sender@email.com" },
    { name: "Recipient", email: "recipient@email.com" },
    game_id)
  Capybara.app.settings.invite_store.add(new_invite)
  visit "/join/#{game_id}/recipient@email.com"
end

Given(/^I am on the Join the Game page$/) do
  game_id = Capybara.app.settings.game_store.list.last.id
  visit "/join/#{game_id}/recipient@email.com"
end

When(/^I input my email address$/) do
  page.fill_in("Your Email", with: "recipient@email.com")
end

# When(/^I input (\d+) clues$/) do | num_clues |
#   num_clues.to_i.times do | i |
#     page.fill_in("Clue #{ i + 1 }", with: "Person Clue #{ i + 1 }")
#   end
# end

When(/^I click the Join Game button$/) do
  click_button "Join Game!"
end

Then(/^I see the Game Overview page$/) do
  expect(page).to have_content "Game Details"
end

Then(/^I see my email address listed as joined in the list of players$/) do
  expect(page).to have_content "recipient@email.com"
end
