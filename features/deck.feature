Feature: Card Decks
    In order to play the pioneer card game
    attendees of the mountain.rb conference
    need to organize their cards into decks

    Scenario: The correct number of cards
        Given a deck with 6 cards
        Then the deck should be valid

    Scenario: The wrong number of cards
        Given a deck with 7 cards
        Then the deck should not be valid
