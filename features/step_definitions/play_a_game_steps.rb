Before do
  @game_players = []
  @potential_clues = Clues.new
  @mails = []
  @game_id = nil
end

Given(/^(.*?) has created a game$/) do | game_creator_name |
  @game_creator_name = game_creator_name
end

Given(/^his email address is "(.*?)"$/) do | game_creator_email |
  @game_creator_email = game_creator_email
end

Given(/^he invited players to the game$/) do |table|
  visit "/"
  fill_in("creator_name", :with => @game_creator_name)
  fill_in("creator_email", :with => @game_creator_email)

  @potential_clues.random.each_with_index do |clue, i|
    fill_in("clue_#{i + 1}", :with => clue)
  end

  table.hashes.each_with_index do | player, i |
    fill_in("friend_#{i + 1}", :with => player[:email])
  end

  allow(Pony).to receive(:mail) do |arg|
    @mails << arg
  end

  click_button "Create Game"
  expect(@mails.length).to eql(table.hashes.length)
  @game_id = page.current_path.split('/').last
  expect(page.current_path).to start_with("/game_overview/")
  expect(page.find('.status').text).to eql('Status: Waiting for players')
end

Given(/^the players all join the game$/) do
  @mails.each do |mail|
    visit "/join/#{@game_id}/#{mail[:to]}"
    @potential_clues.random.each_with_index do |clue, i|
        fill_in("clue_#{i + 1}", :with => clue)
    end
    click_button "Join Game!"
    expect(page).to have_content "Game Details"
    expect(page).to have_content mail[:to]
  end

  expect(page.find('.status').text).to eql('Status: Ready to play!')
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
