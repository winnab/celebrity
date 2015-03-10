Given(/^I have created a game$/) do
  step "I am on the homepage"
  step "I input my name"
  step "I input my email"
  step "I input 5 clues"
  step "I input 5 email addresses"
  step "I click the Create Game button"
  step "I see the new game with my name and the email addresses"
end

When(/^I click the "(.*?)" link$/) do |arg1|
  click_link arg1
end
