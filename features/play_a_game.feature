Feature: Play a Game
  Scenario: Play existing game
    Given "Star-Lord" has created a game with clues
    And "Groot, Thanos, Gamora, Rocket Racoon, and Ronan the Accuser" have joined the game
    When the game is started
    Then the team names are listed
    And there is a list of players for each team

