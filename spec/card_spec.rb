require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'card'

describe Card do
  it "has a name and face value" do
    c = Card.new('burro',9)
    c.name.should == 'Burro'
    c.value.should == 9
  end

  it "identifies land cards" do
    ['Mountain','Forest','Plains'].each do |n|
      Card.new(n,3).type.should == :land
    end
  end

  it "identifies tools" do
    %w{Lasso Pickaxe Plow Trap}.each do |n|
      Card.new(n,3).type.should == :tool
    end
  end

  it "identifies resources" do
    ['Cattle','Ore Vein','Seeds','Wild Game'].each do |n|
      Card.new(n,3).type.should == :resource
    end
  end

  it "identifies beasts" do
    ['Horse','Burro','Ox'].each do |n|
      Card.new(n,3).type.should == :beast
    end
  end

  it "identifies bonuses" do
    ['Circus','Guitar','Opera House','Railroad','Rifle','Whiskey'].each do |n|
      Card.new(n,3).type.should == :bonus
    end
  end

  it "Parses string values" do
    c = Card.parse "Magic Carpet 100"
    c.name.should == 'Magic Carpet'
    c.value.should == 100
  end
end
