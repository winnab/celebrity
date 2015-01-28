Feature: Create a Game
  Background:
    A game is created by one person
    A game can only be created via the "Click Game" button on the homepage

  Scenario: Fill in form on homepage
    Given I am on the homepage
    And   I input my name
    And   I click the "Create Game" button
    Then  I see the new game with myself as the only user
