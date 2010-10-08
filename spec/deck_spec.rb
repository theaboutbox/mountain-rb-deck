require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'deck'
require 'card'

describe Deck do
  it "adds cards via a string" do
    d = Deck.new
    d.add_card "Horse 11"
    d.cards.should have_card "Horse 11"
  end

  it "considers six cards valid" do
    d = Deck.new
    (1..6).each do 
      d.cards << Card.new('Foo',1)
    end
    d.should be_valid
  end

  it "rejects any other number of cards" do
    d = Deck.new
    (1..7).each do
      d.cards << Card.new('foo',1)
    end
    d.should_not be_valid
  end

  describe "filtering" do
    before :each do
      @deck = Deck.new
      @deck.cards << Card.new('Mountain',3)
      @deck.cards << Card.new('Lasso',1)
      @deck.cards << Card.new('Horse',4)
      @deck.cards << Card.new('Wild Game',5)
      @deck.cards << Card.new('Circus',3)
      @deck.cards << Card.new('Whiskey',5)
    end

    it "finds bonus cards" do
      @deck.bonus_cards.size.should == 2
      @deck.bonus_cards.should have_card('Circus 3')
      @deck.bonus_cards.should have_card('Whiskey 5')
    end

    it "finds land cards" do
      @deck.land_cards.should have_card('Mountain 3')
    end

    it "finds tool cards" do
      @deck.tool_cards.should have_card('Lasso 1')
    end

    it "finds resource cards" do
      @deck.resource_cards.should have_card('Wild Game 5')
    end

    it "finds beast cards" do
      @deck.beast_cards.should have_card('Horse 4')
    end

    it "finds by type" do
      @deck.has_card?('Horse').should be_true
      @deck.has_card?('Monkey').should be_false
    end
  end
end
