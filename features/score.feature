Feature: Scoring cards online
    In order to determine their score
    Mountain.rb people can go online and
    enter their card information

    Scenario: Posting a score form
        Given I am on the home page
        And I select "Trapper" from "occupation"
        And I fill in these cards:
            | Card + Value  |
            | horse 4       |
            | Forest 9      |
            | Circus 6      |
            | Whiskey 3     |
            | Wild Game 3   |
            | Trap 3        |
        And I press "submit"
        Then I should see a "resource score" of 3
        And I should see a "land score" of 9
        And I should see a "tool score" of 3
        And I should see a "beast score" of 4
        And I should see a "bonus score" of 9
        And I should see a "total score" of 28
