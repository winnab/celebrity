Given(/^I enter my name$/) do
  page.fill_in("sender_name", with: "Hob")
end

And(/^I enter my email address$/) do
  page.fill_in("sender_email", with: "hob@example.com")
end

Given(/^I enter the recipients's name$/) do
  page.fill_in("invite_name", with: "Lob")
end

Given(/^I enter the recipients's email address$/) do
  page.fill_in("invite_email", with: "lob@example.com")
end

When(/^I click the Invite Player button$/) do
  click_button "Invite Player"
end

And(/^I see the recipient's email in the list$/) do
  expect(page.find(".invite-recipients")).to have_content "Lob"
  expect(page.find(".invite-recipients")).to have_content "lob@example.com"
end

Then(/^The recipient is listed as invited$/) do
  expect(page.find(".invite-recipients")).to have_content "lob@example.com"
  pending # expect(page.find("ul")).to have_content "not joined"
end

Then(/^The recipient recieves an email$/) do
  pending # expect(Pony).to have_received(:mail).with(to: "lob@example.com")
end

