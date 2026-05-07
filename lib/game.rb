require_relative "players"

# Starts and runs game
class Game
  attr_accessor :player1, :player2, :cat_score

  def initialize(player1 = Players.new(nil, nil), player2 = Players.new(nil, nil), takenspaces = nil)
    @takenspaces = takenspaces || [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @player_turn = ""
    @players_created = false
    @player1 = player1
    @player2 = player2
    @cat_score = 0
  end

  def new_round
    @takenspaces = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @players_created ? play : new_game
  end

  def new_game
    @player1 = Players.new
    @player2 = Players.new
    check_symbols
    puts "\n#{@player1.name} is #{@player1.symbol} and #{@player2.name} is #{@player2.symbol}\n\n"
    reset
    send_board
    play
  end

  def check_symbols
    @player2.symbol = @player2.set_symbol if @player1.symbol == @player2.symbol
    check_symbols if @player1.symbol == @player2.symbol
  end

  def reset
    @cat_score = 0
    @player_turn = @player1.name
    @players_created = true
    @takenspaces = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def play
    input = user_input
    update_board(input)
    play if game_over == false
  end

  def update_board(input)
    @takenspaces[input - 1] = @player_turn == @player1.name ? @player1.symbol : @player2.symbol
    change_turn
    send_board
  end

  def change_turn
    @player_turn = @player_turn == @player1.name ? @player2.name : @player1.name
  end

  def send_board
    puts "
------------------------------
 #{@takenspaces[0]} | #{@takenspaces[1]} | #{@takenspaces[2]}     1 | 2 | 3
---+---+---   ---+---+---
 #{@takenspaces[3]} | #{@takenspaces[4]} | #{@takenspaces[5]}     4 | 5 | 6
---+---+---   ---+---+---
 #{@takenspaces[6]} | #{@takenspaces[7]} | #{@takenspaces[8]}     7 | 8 | 9

#{@player1.name} is #{@player1.symbol} | #{@player2.name} is #{@player2.symbol}
------------------------------
"
  end

  def user_input(msg = " please enter where you want to go... (1-9)")
    puts @player_turn + msg
    user_input = gets.chomp.to_i
    user_input = user_input(" please enter a valid input (1-9), that is not taken...") if
      user_input <= 0 ||
      user_input > 9 ||
      !space_taken?(user_input)
    user_input
  end

  def space_taken?(space)
    @takenspaces[space - 1] == " "
  end

  def winning_conditions
    [
      [@takenspaces[0], @takenspaces[1], @takenspaces[2]],
      [@takenspaces[3], @takenspaces[4], @takenspaces[5]],
      [@takenspaces[6], @takenspaces[7], @takenspaces[8]],
      [@takenspaces[0], @takenspaces[3], @takenspaces[6]],
      [@takenspaces[1], @takenspaces[4], @takenspaces[7]],
      [@takenspaces[2], @takenspaces[5], @takenspaces[8]],
      [@takenspaces[0], @takenspaces[4], @takenspaces[8]],
      [@takenspaces[2], @takenspaces[4], @takenspaces[6]]
    ]
  end

  def game_over
    if winning_conditions.include?(Array.new(3, @player1.symbol))
      @player1.score += 1
      winner(@player1.name)
      true
    elsif winning_conditions.include?(Array.new(3, @player2.symbol))
      @player2.score += 1
      winner(@player2.name)
      true
    elsif @takenspaces.none?(" ")
      @cat_score += 1
      winner("Cat")
      true
    else
      false
    end
  end

  def winner(winner)
    puts "#{winner} is the winner!"
  end
end
