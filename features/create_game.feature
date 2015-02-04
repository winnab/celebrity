Feature: Create a Game
  Scenario: Create a game on the homepage
    Given I am on the homepage
    And   I input my name
    And   I click the Create Game button
    Then  I see the new game with myself as the only user
