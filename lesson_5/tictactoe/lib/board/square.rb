class Square
  attr_accessor :display_color, :value
  attr_reader :color
  
  @@total = 0
  
  def initialize
    @@total += 1
    @color = (@@total % 2).zero? ? :cyan : :pink
    @display_color = color
    @value = ' '
  end
  
  def <=>
    value <=> value
  end
end