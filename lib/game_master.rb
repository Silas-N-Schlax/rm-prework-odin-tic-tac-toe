require_relative "game"

# Controls game
class GameMaster
  attr_accessor :tic_tac_toe

  def initialize
    @tic_tac_toe = Game.new
  end

  def master_controls
    puts "Please enter a key word to continue (type help for key words)"
    keyword = gets.chomp.downcase
    call_method(keyword)
    master_controls if keyword != "e"
    puts "Thank you for playing!\nexitting..."
  end

  def call_method(key)
    case key
    when "s"
      puts scoreboard
    when "r"
      new_round
    when "g"
      new_game
    when "h"
      help
    end
  end

  def help
    puts "
    ---------------------
    keywords include:
    - New Game (g)
    - New Round (r)
    - Exit (e)
    - Soreboard (s)
    - Help (h)
    ---------------------
    "
  end

  def new_round
    tic_tac_toe.new_round
  end

  def new_game
    puts "Use 'new game (n)' to keep current scores, otherwise type 'y'"
    puts "canceling..." if gets.chomp != "y"
    tic_tac_toe.new_game
  end

  def scoreboard
    tic_tac_toe.player1.nil? ? "Please play a game first!" : generate_scoreboard
  end

  def generate_scoreboard
    "
    ---------------------
    Scoreboard:
    #{tic_tac_toe.player1.name}: #{tic_tac_toe.player1.score}
    #{tic_tac_toe.player2.name}: #{tic_tac_toe.player2.score}
    Cat: #{tic_tac_toe.cat_score}
    ---------------------"
  end
end
