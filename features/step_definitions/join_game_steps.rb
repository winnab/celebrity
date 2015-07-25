Before do
  game = Game.new
  clues = Clues.new.creator_clues
  creator = Player.new(game.id, "Winna", clues)

  Capybara.app.settings.player_store.add(creator)
  Capybara.app.settings.game_store.add(game)

  @game = Capybara.app.settings.game_store.list.last
end

Given(/^A game has been created$/) do
  expect(Capybara.app.settings.game_store.list).to include(@game)
end

Given(/^I have been invited to the game$/) do
  game_id = @game.id
  visit "/join/#{game_id}"
end

Given(/^I am on the Join the Game page$/) do
  game_id = @game.id
  visit "/join/#{game_id}"
end

When(/^I click the Join Game button$/) do
  fill_in("player_name", :with => "Bob")
  fill_in("clue_1", :with => "bob_clue_1")
  fill_in("clue_2", :with => "bob_clue_2")
  fill_in("clue_3", :with => "bob_clue_3")
  fill_in("clue_4", :with => "bob_clue_4")
  fill_in("clue_5", :with => "bob_clue_5")

  click_button "Join Game!"
end

Then(/^I see the Game Overview page$/) do
  expect(page).to have_content "Game Details"
end

Then(/^I see my name listed as joined in the list of players$/) do
  expect(page).to have_content "Bob"
end
