Feature: Join a Game
  Background: Players are invited to the game via URL.
    Given A game has been created

  Scenario: Join a game after clicking the invitation link
    Given I am on the Join the Game page
    And   I input my name
    And   I input 5 clues
    And   I click the Join Game button
    Then  I see the Game Overview page
    And   I see my name listed as joined in the list of players
