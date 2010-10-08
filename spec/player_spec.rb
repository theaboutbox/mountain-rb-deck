require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'deck'
require 'card'
require 'player'

describe Player do

  context "scoring" do
    before :each do
      @deck = Deck.new
      @deck.cards << Card.new('Mountain',3)
      @deck.cards << Card.new('Lasso',1)
      @deck.cards << Card.new('Horse',4)
      @deck.cards << Card.new('Cattle',5)
      @deck.cards << Card.new('Circus',3)
      @deck.cards << Card.new('Whiskey',5)
      @player = Player.new('Joe','Cowboy',@deck)
    end

    it "Calculates a bonus score" do
      @player.bonus_score.should == 8
    end

    it "Calculates a resource score" do
      @player.resource_score.should == 5
    end
    
    it "Calculates modified land values" do
      @player.land_score.should == 1
    end
    
    it "Calculates a tool score" do
      @player.tool_score.should == 1
    end
    it "Calculates a beast score" do
      @player.beast_score.should == 2
    end

  end

  context "rules" do
    before :each do
      @d = Deck.new
      @p = Player.new('Test','Test',@d)
    end

    it "requires trappers to have a trap to use resources" do
      @p.occupation = 'Trapper'
      @d.add_card 'Lasso 10'
      @d.add_card 'Cattle 10'
      @p.resource_score.should == 0
    end

    it "requires prospectors to have a pickaxe to use resources" do
      @p.occupation = 'Prospector'
      @d.add_card 'Ore Vein 100'
      c = Card.parse 'Lasso 10'
      @d.cards << c
      @p.resource_score.should == 0
      c.name = 'Pickaxe'
      @p.resource_score.should == 100
    end

    it "gives a cowboy without a horse a resource score of zero" do
      @p.occupation = 'Cowboy'
      @d.add_card 'Lasso 10'
      @d.add_card 'Cattle 10'
      @p.resource_score.should == 0
      @d.add_card 'Horse 1'
      @p.resource_score.should == 10
    end
    
    it "requires homesteaders to have a plow to use resources" do
      @p.occupation = 'Homesteader'
      @d.add_card 'Seeds 10'
      c = Card.parse 'Pickaxe 10'
      @d.cards << c
      @p.resource_score.should == 0
      c.name = 'Plow'
      @p.resource_score.should == 10
    end

    it "requires a lasso to use cattle" do
      @p.occupation = 'Cowboy'
      @d.add_card 'Cattle 10'
      @d.add_card 'Horse 1'
      c = Card.parse 'Pickaxe 10'
      @d.cards << c
      @p.resource_score.should == 0
      c.name = 'Lasso'
      @p.resource_score.should == 10
    end

    it "requires a pickaxe to mine ore" do
      @p.occupation = 'Prospector'
      @d.add_card 'Ore Vein 10'
      c = Card.parse 'Lasso 10'
      @d.cards << c
      @p.resource_score.should == 0
      c.name = 'Pickaxe'
      @p.resource_score.should == 10
    end

    it "requires a plow to plant seeds" do
      @p.occupation = 'Homesteader'
      @d.add_card 'Seeds 10'
      c = Card.parse 'Pickaxe 10'
      @d.cards << c
      @p.resource_score.should == 0
      c.name = 'Plow'
      @p.resource_score.should == 10
    end

    it "requires a trap to catch game" do
      @d.cards << Card.new('Wild Game',100)
      @d.cards << Card.new('Lasso',50)
      @p.occupation = 'Trapper'
      @p.resource_score.should == 0
    end

    it "doubles a burro's points in the mountains" do
      @d.add_card 'Burro 10'
      @d.add_card 'Mountain 1'
      @p.beast_score.should == 20
    end
    
    it "halves a horse's points in the mountains" do
      @d.add_card 'Horse 5'
      @d.add_card 'Mountain 1'
      @p.beast_score.should == 2
    end

    it "doubles an ox's points for a homesteader" do
      @p.occupation = 'Homesteader'
      @d.add_card 'Ox 5'
      @p.beast_score.should == 10
    end

    it "halves resource values for cattle in mountains" do
      @d.add_card 'Cattle 5'
      @d.add_card 'Mountain 5'
      @p.land_score.should == 2
    end

    it "zeros cattle in forest" do
      @d.add_card 'Cattle 5'
      @d.add_card 'Forest 10'
      @p.land_score.should == 0
    end

    it "halves resource values for ore in forest" do
      @d.add_card 'Ore Vein 3'
      @d.add_card 'Forest 3'
      @p.land_score.should == 1
    end

    it "zeros ore for plains" do
      @d.add_card 'Ore Vein 10'
      @d.add_card 'Plains 1'
      @p.land_score.should == 0
    end

    it "halves resource values for seeds" do
      @d.add_card 'Seeds 5'
      @d.add_card 'Forest 3'
      @p.land_score.should == 1
    end

    it "zeros seeds in mountains" do
      @d.add_card 'Seeds 5'
      @d.add_card 'Mountain 3'
      @p.land_score.should == 0
    end

    it "halves value of mountains for game" do
      @d.add_card 'Wild Game 5'
      @d.add_card 'Mountain 2'
      @p.land_score.should == 1
    end

    it "zeros value of plains with wild game" do
      @d.add_card 'Wild Game 5'
      @d.add_card 'Plains 10'
      @p.land_score.should == 0
    end
    
    it "requires cowboys to have a horse to use resources" do
      @p.occupation = 'Cowboy'
      @d.add_card 'Lasso 10'
      @d.add_card 'Cattle 10'
      @p.resource_score.should == 0
      @d.add_card 'Horse 1'
      @p.resource_score.should == 10
    end
  end
end
