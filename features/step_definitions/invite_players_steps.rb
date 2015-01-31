When(/^I am on the game overview page$/) do
  expect(page.current_path).to eq('/game_overview')
end

When(/^I enter a player's email address$/) do
  page.fill_in("Invite player", with: 'bob@gmail.com')
end

Then(/^I see the player's email in the list$/) do
  expect(page.find('ul')).to have_content "bob@gmail.com"
end

Then(/^the player is listed as "(.*?)"$/) do | arg1 |
  expect(page.find('ul')).to have_content arg1
end
