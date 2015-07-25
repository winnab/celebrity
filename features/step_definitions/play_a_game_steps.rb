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
  fill_in("clue_1", :with => clues[0])
  fill_in("clue_2", :with => clues[1])
  fill_in("clue_3", :with => clues[2])
  fill_in("clue_4", :with => clues[3])
  fill_in("clue_5", :with => clues[4])

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

When(/^the game is started$/) do
  game_id = @game.id
  visit "/game_overview/#{game_id}"
  click_link "Start Game"
end

Then(/^the team names are listed$/) do
  @game.teams.each do |team|
    expect(page).to have_content team.name
  end
end

Then(/^there is a list of players for each team$/) do
  @game.teams.each do |team|
    team.players.each do |player|
      expect(page).to have_content player.name
    end
  end
end
