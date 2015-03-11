Feature: Invite Players
  Background:
    Given I have created a game

  Scenario: Inviting a player
    Given I enter my name
    And   I enter my email address
    And   I enter the recipients's name
    And   I enter the recipients's email address
    When  I click the Invite Player button
    Then  I see the recipient's email in the list
    And   The recipient is listed as invited
    And   The recipient recieves an email
