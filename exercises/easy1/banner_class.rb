class Banner
  attr_reader :message, :width
  
  def initialize(message, width = nil)
    @message = message
    @width = width == nil ? message.size : width
  end

  def to_s
    [horizontal_rule, empty_line, message_line,
     empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-" + ("-" * width) + "-+"
  end

  def empty_line
    "| " + (" " * width) + " |"
  end

  def message_line
    spacing = ((width - message.size) / 2)
    "| " + (" " * spacing) + message + (" " * spacing) + " |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+