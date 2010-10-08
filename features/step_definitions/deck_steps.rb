Given /^a deck with (\d+) cards$/ do |card_count|
  @deck = Deck.new
  (1..card_count.to_i).each do 
    @deck.cards.push Card.new('Test',1)
  end
end

Then /^the deck should be valid$/ do
  @deck.should be_valid
end

Then /^the deck should not be valid$/ do
  @deck.should_not be_valid
end

