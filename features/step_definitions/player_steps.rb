def table_to_deck(table)
  d = Deck.new
  table.hashes.each do |h|
    d.cards.push Card.new(h['Name'],h['Points'].to_i)
  end
  d
end

Given /^a "([^"]*)" player with the following cards:$/ do |occupation, table|
  @player = Player.new('Test Player',occupation,table_to_deck(table))
end

Then /^the resource total should be (\d+)$/ do |score|
  @player.resource_total.should == score.to_i
end

Given /^a player with the following cards:$/ do |table|
  @player = Player.new('Test Player','Test',table_to_deck(table))
end

Then /^the bonus score should be (\d+)$/ do |score|
  @player.bonus_score.should == score.to_i
end

Then /^the resource score should be (\d+)$/ do |arg1|
  @player.resource_score.should == arg1.to_i
end

Then /^the land score should be (\d+)$/ do |arg1|
  @player.land_score.should == arg1.to_i
end

Then /^the tool score should be (\d+)$/ do |arg1|
  @player.tool_score.should == arg1.to_i
end

Then /^the beast score should be (\d+)$/ do |arg1|
  @player.beast_score.should == arg1.to_i
end

