Given(/^I am on the homepage$/) do
  visit "/"
end

When(/^I input my name$/) do
  fill_in("creator_name", :with => "Winna")
end

When(/^I click the Create Game button$/) do
  click_button "Create Game"
end

Then(/^I see the new game with myself as the only user$/) do
  expect(page.find("ul")).to have_content "Winna"
end
