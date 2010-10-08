class Player
  attr_accessor :name, :occupation, :deck

  def initialize(name, occupation, deck)
    @name = name
    @occupation = occupation
    @deck = deck
  end

  def resource_total
    resource_score + land_score + beast_score + tool_score
  end

  def resource_score
    # Players need to have their tool to use resources
    case occupation
    when 'Trapper'
      return 0 unless @deck.has_card? 'Trap'
    when 'Cowboy'
      return 0 unless @deck.has_card? 'Lasso'
      return 0 unless @deck.has_card? 'Horse'
    when 'Homesteader'
      return 0 unless @deck.has_card? 'Plow'
    when 'Prospector'
      return 0 unless @deck.has_card? 'Pickaxe'
    end

    # Tools are paired with resources
    resources = deck.resource_cards
    resources.inject(0) do |score, card|
      case card.name 
      when 'Cattle'
        score + card.value if @deck.has_card? 'Lasso'
      when 'Ore Vein'
        score + card.value if @deck.has_card? 'Pickaxe'
      when 'Seeds'
        score + card.value if @deck.has_card? 'Plow'
      when 'Wild Game'
        score + card.value if @deck.has_card? 'Trap'
      else
        score
      end
    end
  end

  def beast_score
    beasts = deck.beast_cards
    beasts.inject(0) do |score,card|
      case card.name
      when 'Burro'
        return score + 2 * card.value if @deck.has_card? 'Mountain'
      when 'Horse'
        return score + (card.value / 2).floor if @deck.has_card? 'Mountain'
      when 'Ox'
        return score + 2 * card.value if @occupation == 'Homesteader'
      end
      return score + card.value
    end
  end

  def land_score
    deck.land_cards.inject(0) do |score,card|
      case card.name
      when 'Mountain'
        return score + card.value if @deck.has_card? 'Ore Vein'
        if @deck.has_card?('Cattle') || @deck.has_card?('Wild Game')
          return score + (card.value/2).floor
        end
        return score
      when 'Forest'
        return score + card.value if @deck.has_card? 'Wild Game'
        return score + (card.value/2).floor if @deck.has_card?('Ore Vein') || @deck.has_card?('Seeds')
        return score
      when 'Plains'
        return score + card.value if @deck.has_card?('Cattle') || @deck.has_card?('Seeds')
        return score
      end
    end
  end
  
  def tool_score
    deck.tool_cards.inject(0) {|score,card| score + card.value}
  end

  def bonus_score
    deck.bonus_cards.inject(0) { |acc,card| acc + card.value }
  end

  def total_score
    resource_total + bonus_score
  end
end
