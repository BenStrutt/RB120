class String
  COLORS = { cyan: 46, pink: 45, yellow: 43 }
  
  def color(color)
    "\e[#{COLORS[color]}m#{self}\e[0m"
  end
  
  def non_numeric?
    return false if self =~ /^\d+$/
    
    true
  end
end

class Array
  def exclude?(value)
    self.each { |element| return false if element == value }
    
    true
  end
end