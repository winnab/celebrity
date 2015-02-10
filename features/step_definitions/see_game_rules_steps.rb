Then(/^I see a page that lists all the rules for the game$/) do
  expect(page).to have_content("Invite players")
end
