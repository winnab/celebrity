require_relative "../../lib/player.rb"

When(/^I input my name$/) do
  player = Player.new("Winna")
  fill_in("creator_name", :with => player.name)
end

Then(/^I see the new game with myself as the only user$/) do
  player = Player.new("Winna")
  expect(page).to have_text(player.name)
end
