require_relative 'board/board.rb'
require_relative 'player/human.rb'
require_relative 'player/computer.rb'
require_relative 'modules/terminaldisplay.rb'

require 'pry'

class TicTacToe
  include TerminalDisplay
  
  attr_reader :board, :players, :match_length
  
  def play
    welcome
    initialize_game
    game_loop
  end
  
  private
  
  def welcome
    clear
    say 'welcome'
    wait
  end
  
  def initialize_game
    @board = Board.new
    initialize_players
    @match_length = initialize_match_length
  end

  def initialize_players
    @players = []
    player_amount('human').times { @players << Human.new }
    player_amount('computer').times { @players << Computer.new }
  end
  
  def player_amount(type)
    sub_message = type == 'human' ? ' total ' : ' more '
    message = MESSAGES[type] + "\nYou can have #{board.size - Player.total}" +
              sub_message + "players.\n\n-> "
    prompt(message, player_amount_validation, player_amount_errors).to_i
  end
  
  def player_amount_validation
    Proc.new do |answer|
      answer =~ /^[0-9]{1}$/ && answer.to_i <= board.size - Player.total
    end
  end
  
  def player_amount_errors
    Proc.new do |answer|
      case
      when answer.empty? then 'no_response_given'
      when answer.non_numeric? then 'response_non_numeric'
      when answer.to_i + Player.total > board.size then 'too_many_players'
      else 'unknown_error'
      end
    end
  end
  
  def initialize_match_length
    message = MESSAGES['prompt_match_length']
    prompt(message, match_length_validation, match_length_errors).to_i
  end
  
  def match_length_validation
    Proc.new do |answer|
      answer =~ /^\d+$/ && answer.to_i >= 1 && answer.to_i <= 50
    end
  end
  
  def match_length_errors
    Proc.new do |answer|
      case
      when answer.empty? then 'no_response_given'
      when answer.non_numeric? then 'response_non_numeric'
      when answer.to_i < 1 then 'match_length_too_small'
      when answer.to_i > 50 then 'match_length_too_large'
      else 'unknown_error'
      end
    end
  end
  
  def game_loop
    loop do
      choice_loop
      update_game if board.win?
      if match_over?
        show_match_result
        break unless play_again?
        
        reset_game_parameters
      end
    end
  end
  
  def choice_loop
    loop do
      players.each do |player|
        player.choose_move(board, players)
        break if game_over?
      end
      break if game_over?
    end
  end
  
  def update_game
    winner = players.select { |player| player.marker == board.win? }.first
    winner.score += 1
    show_win(winner)
    board.reset
  end
  
  def game_over?
    board.full? || board.win?
  end
  
  def match_over?
    players.each { |player| return true if player.score == match_length }
    
    false
  end
  
  def show_win(winner)
    clear
    board.draw
    puts "\n#{winner.name} won!\nPress any key to continue.\n"
    wait
  end
end