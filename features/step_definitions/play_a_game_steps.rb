Before do
  @game_players = []
  @potential_clues = Clues.new
  @mails = []
  @game_id = nil
end

Given(/^(.*?) has created a game with clues$/) do | game_creator_name |
  @creator = game_creator_name.gsub("\"", "")
  clues = Clues.new.creator_clues

  visit "/"

  fill_in("player_name", :with => @creator)
  fill_in("clue_1", :with => "#{clues[0]}")
  fill_in("clue_2", :with => "#{clues[1]}")
  fill_in("clue_3", :with => "#{clues[2]}")
  fill_in("clue_4", :with => "#{clues[3]}")
  fill_in("clue_5", :with => "#{clues[4]}")

  click_button "Create Game"

  @game = Capybara.app.settings.game_store.list.last

  expect(page.find(".joined-players")).to have_content "Star-Lord"

end

Given(/^"(.*?)" have joined the game$/) do |friends|
  friend_list = friends.split(", ")
  friend_list[4].gsub!("and ", "")
  clues = Clues.new.joined_players_clues

  friend_list.each do | friend |
    game_id = @game.id
    visit "/join/#{game_id}"

    fill_in("player_name", :with => friend)
    fill_in("clue_1", :with => clues[0])
    fill_in("clue_2", :with => clues[1])
    fill_in("clue_3", :with => clues[2])
    fill_in("clue_4", :with => clues[3])
    fill_in("clue_5", :with => clues[4])

    click_button "Join Game!"
    clues.shift(5)
    expect(page).to have_content friend
  end
end

Given(/^the game will set team and player order as follows:$/) do |table|
  pending # express the regexp above with the code you wish you had
end

When(/^(.*?) starts the game$/) do |game_creator|
  pending # express the regexp above with the code you wish you had
end

Then(/^round (\d+) starts$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be Neil's turn$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^(\d+) clues are guessed$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the scores should be:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be Winna's turn$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^(\d+) clues are guessed and (\d+) are skipped$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be Divya's turn$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be Gautam's turn$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the round is over$/) do
  pending # express the regexp above with the code you wish you had
end
