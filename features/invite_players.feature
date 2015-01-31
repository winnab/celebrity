Feature: Invite Players
  Scenario:
    Given I am on the homepage
    And   I input my name
    And   I click the "Create Game" button
    When I am on the game overview page
    And I enter a player's email address
    And I click the "Invite Player" button
    Then I see the player's email in the list
    And the player is listed as "not joined"

