Feature: Create a Game
  Scenario: Create a game on the homepage
    Given I am on the homepage
    When  I input my name
    And   I input my email
    And   I input 5 clues
    And   I input 6 email addresses
    And   I click the Create Game button
    Then  I see the new game with my name and the email addresses
