Given(/^I have created a game$/) do
  step "I am on the homepage"
  step "I input my name"
  step "I click the Create Game button"
  step "I see the new game with myself as the only user"
end

When(/^I click the "(.*?)" link$/) do |arg1|
  click_link arg1
end
