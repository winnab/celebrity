Feature: Invite Players
  Background:
    Given I have created a game

  Scenario: Inviting a player
    Given I enter a player's email address
    When  I click the Invite Player button
    Then  I see the player's email in the list
    And   the player is listed as not joined

  Scenario: Receive an invite
    Given I've been invited to a game
    Then  I should have received an email invitation
    And   it has a nice welcome message
    And   a link to the game
