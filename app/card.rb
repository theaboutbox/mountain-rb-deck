class Card
  attr_accessor :name, :value
  attr_reader :type

  def initialize(n,v)
    @name = n.titleize
    @value = v
    @type = type_for @name
  end

  private
  
  def type_for(n)
    case n
    when 'Mountain','Forest','Plains' then :land
    when 'Lasso','Pickaxe','Plow','Trap' then :tool
    when 'Cattle','Ore Vein','Seeds','Wild Game' then :resource
    when 'Horse','Burro','Ox' then :beast
    when 'Circus','Guitar','Opera House','Railroad','Rifle','Whiskey' then :bonus
    else :unknown
    end
  end

  def self.parse(str)
    md = /([\w\s]+) (\d+)$/.match str
    nil if md.nil?
    Card.new(md[1],md[2].to_i)
  end
end
