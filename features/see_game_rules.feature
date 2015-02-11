Feature: List Rules of Game
  Scenario: View the rules for the game
    Given I am on the homepage
    When  I click the "Rules" link
    Then  I see a page that lists all the rules for the game
