class Transform
  def initialize(ipt)
    @ipt = ipt
  end
  
  def uppercase
    @ipt.upcase
  end
  
  def self.lowercase(ipt)
    ipt.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# ABC
# xyz