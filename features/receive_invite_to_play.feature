Feature: Receive Invite
  Background:
    Given I have created a game

  Scenario: Receive an invite
    Given I've been invited to a game
    Then  I should have received an email invitation
    And   it has a nice welcome message
    And   a link to the game
