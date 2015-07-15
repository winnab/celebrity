Feature: Create a Game
  Scenario: Create a game on the homepage
    Given I am on the homepage
    When  I input my name
    And   I input 5 clues
    And   I click the Create Game button
    Then  I see the new game with my name
