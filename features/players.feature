Feature: Players
    In order to obtain a score in the mountain.rb card game
    Attendees at the conference
    Need to calculate scores for a player's deck

    Scenario: Computing resource points for a cowboy
        Given a "Cowboy" player with the following cards:
            | Name          | Points |
            | Cattle        | 3      |
            | Mountain      | 5      |
            | Lasso         | 1      |
            | Horse         | 2      |
        Then the resource total should be 7

    Scenario: Computing resource points for a prospector
        Given a "Prospector" player with the following cards:
            | Name     | Points |
            | Ore Vein | 1      |
            | Ore Vein | 5      |
            | Mountain | 3      |
            | Pickaxe  | 4      |
            | Burro    | 2      |
        Then the resource score should be 6
        And the land score should be 3
        And the tool score should be 4
        And the beast score should be 4
        And the resource total should be 17

    Scenario: Computing bonus points
        Given a player with the following cards:
            | Name   | Points |
            | Circus | 3      |
            | Circus | 3      |
            | Circus | 6      |
        Then the bonus score should be 12

