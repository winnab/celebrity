Given(/^A game has been created$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have been invited to the game$/) do
  game_id = Capybara.app.settings.game_store.list.last.id
  visit "/join/#{game_id}"
end

Given(/^I am on the Join the Game page$/) do
  game_id = Capybara.app.settings.game_store.list.last.id
  visit "/join/#{game_id}"
end

When(/^I click the Join Game button$/) do
  click_button "Join Game!"
end

Then(/^I see the Game Overview page$/) do
  expect(page).to have_content "Game Details"
end

Then(/^I see my name listed as joined in the list of players$/) do
  expect(page).to have_content "Bob"
end
