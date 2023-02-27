class Visitor
  attr_accessor :spending_money
  attr_reader :name,
              :height,
              :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = format_spending_money(spending_money)
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(height_requirement)
    @height >= height_requirement
  end

  def format_spending_money(value)
    value.delete('$').to_i
  end
end
