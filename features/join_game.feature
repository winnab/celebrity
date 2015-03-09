Feature: Join a Game
  Background: Players are invited to the game via email.
    Given I have created a game

  Scenario: Join a game after clicking a link in the invitation email
    Given I am on the Join the Game page
    When  I input my email address
    And   I input 5 clues
    And   I click the Join Game button
    Then  I see the Game Overview page
    And   I see my email address listed as joined in the list of players
