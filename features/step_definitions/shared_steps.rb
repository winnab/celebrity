Given(/^I have created a game$/) do
  step "I am on the homepage"
  step "I input my name"
  step "I input 5 clues"
  step "I click the Create Game button"
  step "I see the new game with my name"
end

When(/^I click the "(.*?)" link$/) do |arg1|
  click_link arg1
end

And(/^I input 5 clues$/) do
  fill_in("clue_1", :with => "Clue 1")
  fill_in("clue_2", :with => "Clue 2")
  fill_in("clue_3", :with => "Clue 3")
  fill_in("clue_4", :with => "Clue 4")
  fill_in("clue_5", :with => "Clue 5")
end
