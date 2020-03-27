require_relative '../utility.rb'
require_relative '../modules/terminaldisplay.rb'
require_relative 'square.rb'

require 'pry'

class Board
  include TerminalDisplay
  
  attr_reader :squares, :size, :win_length
  
  def initialize
    @size = prompt_for_size
    @win_length = prompt_for_win_length
    @squares = Array.new(size) { Array.new(size) { Square.new } }
  end
  
  def draw
    squares.each { |row| draw_row(row) }
  end
  
  def full?
    squares.each do |row|
      row.each do |square|
        return false if square.value == ' '
      end
    end
    
    true
  end
  
  def win?
    [rows, columns, diagonals].each do |lines|
      lines.each do |line|
        line.each_cons(win_length) do |squares|
          squares = squares.map(&:value)
          return squares.first if squares.uniq.size == 1 && squares.first != ' '
        end
      end
    end
    
    false
  end
  
  def reset
    squares.each { |rows| rows.each { |square| square.value = ' ' } }
  end

  private
  
  def prompt_for_size
    message = MESSAGES['board_size']
    prompt(message, size_validation, size_errors).to_i
  end
  
  def size_validation
    Proc.new do |answer|
      [3, 5, 7, 9].include?(answer.to_i) && answer =~ /^\d{1}$/
    end
  end
  
  def size_errors
    Proc.new do |answer|
      case
      when answer.empty? then 'no_response_given'
      when answer.non_numeric? then 'response_non_numeric'
      when answer.to_i < 3 then 'board_size_too_small'
      when answer.to_i > 9 then 'board_size_too_large'
      when [3, 5, 7, 9].exclude?(answer) then 'invalid_board_size'
      else 'unknown_error'
      end
    end
  end
  
  def prompt_for_win_length
    return 3 if size == 3
    
    message = "Please choose the amount of squares in a row in order to win." +
              "\nYou can choose a minimum of 2 and a maximum of #{size}.\n\n-> "
    prompt(message, win_length_validation, win_length_errors).to_i
  end
  
  def win_length_validation
    Proc.new { |answer| answer =~ /^[2-#{size}]{1}$/ }
  end
  
  def win_length_errors
    Proc.new do |answer|
      case
      when answer.empty? then 'no_response_given'
      when answer.non_numeric? then 'response_non_numeric'
      when answer.to_i < 2 then 'win_length_too_small'
      when answer.to_i > size then 'win_length_too_large'
      else 'unknown_error'
      end
    end
  end
  
  def draw_row(row)
    3.times do |iteration|
      row.each do |square|
        if iteration.even?
          print "       ".color(square.display_color)
        else
          print "   #{square.value}   ".color(square.display_color)
        end
      end
      print "\n"
    end
  end
  
  def rows
    squares
  end
  
  def columns
    squares.transpose
  end
  
  def diagonals
    result = []
    (0..(size - win_length)).each do |y|
      (0...size).each do |x|
        [1, -1].each do |increment|
          if in_bounds?(x + ((win_length - 1) * increment))
            temp_x = x
            temp_y = y
            diagonal = []
            win_length.times do
              diagonal << squares[temp_x][temp_y]
              temp_x += increment
              temp_y += 1
            end
            result << diagonal
          end
        end
      end
    end
    result
  end

  def in_bounds?(coordinate)
    coordinate >= 0 && coordinate < size
  end
end