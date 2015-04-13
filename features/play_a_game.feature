Feature: Play a game
  Background:
    As a player
    So that I can get into the actual gameplay quickly
    I want to be able to play a demo game without filling in forms

  Scenario: A minimal game
    Given Neil has created a game
    And his email address is "neil@example.com"
    And he invited players to the game
      | players | email  |
      | Winna   | winna@example.com     |
      | Divya   | divya@example.com     |
      | Gautam  | gautam@example.com    |
      | Maloney | maloney@example.com   |
      | Sophie  | sophie@example.com    |
      | Neha    | neha@example.com      |

    And the players all join the game

    And the game will set team and player order as follows:
      | players | team  |
      | Neil    | 1     |
      | Winna   | 2     |
      | Divya   | 1     |
      | Gautam  | 2     |
      | Maloney | 1     |
      | Sophie  | 2     |
      | Neha    | 1     |

    When Neil starts the game
    Then round 1 starts

    Then it should be Neil's turn
    When 10 clues are guessed
    Then the scores should be:
      | team | score |
      |    1 |    10 |
      |    2 |     0 |

    Then it should be Winna's turn
    When 5 clues are guessed and 3 are skipped
    Then the scores should be:
      | team | score |
      |    1 |    10 |
      |    2 |     2 |

    Then it should be Divya's turn
    When 5 clues are guessed
    Then the scores should be:
      | team | score |
      |    1 |    15 |
      |    2 |     2 |

    Then it should be Gautam's turn
    When 15 clues are guessed
    Then the scores should be:
      | team | score |
      |    1 |    15 |
      |    2 |    17 |

    Then the round is over
    And round 2 starts
