require_relative 'player.rb'

class Human < Player
  def choose_move(board, players)
    x = board.size / 2
    y = board.size / 2
    loop do
      system('clear')
      board.squares[x][y].display_color = :yellow
      board.draw
      player_scores(players)
      board.squares[x][y].display_color = board.squares[x][y].color
      case keypress
      when "a" then y -= 1
      when "d" then y += 1
      when "w" then x -= 1
      when "s" then x += 1
      when "\r"
        if board.squares[x][y].value == ' '
          board.squares[x][y].value = marker
          break
        end
      when 'q'
        clear
        abort 'Program aborted from game loop.'
      end
      y = board.size - 1 if y == -1
      y = 0 if y == board.size
      x = board.size - 1 if x == -1
      x = 0 if x == board.size
    end
  end
  
  def player_scores(players)
    players.each do |player|
      puts "#{player.name}: #{player.score}"
    end
  end
end