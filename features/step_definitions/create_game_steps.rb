Given(/^I am on the homepage$/) do
  visit "/"
  click_link "// Clear Session"
end

When(/^I input my name as the game creator$/) do
  fill_in("player_name", :with => "Winna")
end

When(/^I click the Create Game button$/) do
  click_button "Create Game"
end

Then(/^I see the new game with my name$/) do
  expect(page.find(".joined-players")).to have_content "Winna"
end
