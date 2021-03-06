class RPSGame
  attr_reader :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_result
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    display_winner
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n yes no).include? answer.downcase
      puts "sorry, must be y or n."
    end

    %w(y yes).include? answer
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_result
      break unless play_again?
    end

    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if %w(r rock p paper s scissors).include? choice
      puts "Sorry, invalid choice."
    end
    # NEED TO FORMAT THIS FOR CHARACTER CASES
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Chappie Sonny).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other)
    if rock?
      other.scissors?
    elsif paper?
      other.rock?
    else
      other.paper?
    end
  end

  def to_s
    @value
  end
end

# class Rule
#   def initialize
#     # not sure what the "state" of a rule object should be
#   end
# end

# # not sure where "compare" goes yet
# def compare(move1, move2)

# end

RPSGame.new.play
