Given(/^I am on the Join the Game page$/) do
  visit "/join"
end

When(/^I input my email address$/) do
  page.fill_in("Your Email", with: "celeb_fun_wow@example.com")
end

When(/^I input (\d+) clues$/) do | num_clues |
  num_clues.to_i.times do | i |
    page.fill_in("Clue #{ i + 1 }", with: "Person Clue #{ i + 1 }")
  end
end

When(/^I click the Join Game button$/) do
  click_button "Join Game"
end

Then(/^I see the Game Overview page$/) do
  expect(page).to have_content "Game Overview"
end

Then(/^I see my email address listed as joined in the list of players$/) do
  expect(page.find("ul")).to have_content "celeb_fun_wow@example.com"
end
