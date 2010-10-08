class Deck
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_card(str)
    @cards.push Card.parse(str)
  end

  def valid?
    @cards.length == 6
  end

  def has_card?(name)
    !@cards.index { |c| c.name == name }.nil?
  end
  
  def bonus_cards
    find_by_type(:bonus)
  end

  def land_cards
    find_by_type :land
  end

  def tool_cards
    find_by_type :tool
  end

  def resource_cards
    find_by_type :resource
  end

  def beast_cards
    find_by_type :beast
  end

  private

  def find_by_type(type)
    @cards.select { |c| c.type == type }
  end
end
