require_relative "players"

# Starts and runs game
class Game
  attr_accessor :winningconditions, :winner, :takenspaces, :playerturn, :player1_name, :player2_name, :player1_symbol, :player2_symbol, :user_input, :player1_scores, :player2_scores, :cat_scores, :players_created

  def erase_all_data
    @players_created = true
    create_players
    restart
  end

  def restart
    if players_created == true
      self.takenspaces = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      self.winner = " "
      player_input
    else
      erase_all_data
    end
  end

  # ! add into new class
  # def create_players
  #   create_player1
  #   create_player2
  #   puts "\n#{player1_name} is #{player1_symbol} and #{player2_name} is #{player2_symbol}\n\n"
  #   @playerturn = player1_name
  #   create_scores
  # end

  # def create_player1
  #   player1 = Players.new
  #   @player1_name = player1.return_player_name
  #   @player1_symbol = player1.return_symbol
  # end

  # def create_player2
  #   player2 = Players.new
  #   @player2_name = player2.return_player_name
  #   @player2_symbol = player2.return_symbol
  #   until self.player2_symbol != self.player1_symbol
  #     self.player2_symbol = player2.return_symbol
  #   end
  # end

  def winning_conditions
    [
      [takenspaces[0], takenspaces[1], takenspaces[2]],
      [takenspaces[3], takenspaces[4], takenspaces[5]],
      [takenspaces[6], takenspaces[7], takenspaces[8]],
      [takenspaces[0], takenspaces[3], takenspaces[6]],
      [takenspaces[1], takenspaces[4], takenspaces[7]],
      [takenspaces[2], takenspaces[5], takenspaces[8]],
      [takenspaces[0], takenspaces[4], takenspaces[8]],
      [takenspaces[2], takenspaces[4], takenspaces[6]]
    ]
  end

  # def player_input_backend(msg = " please enter where you want to go...")
  #   puts playerturn + msg
  #   @user_input = gets.chomp.to_i
  #   p space_taken?(user_input)
  #   if user_input.negative? || user_input > 9 || !space_taken?(user_input)
  #     player_input_backend(" please enter valid input (1-9), that is not taken...")
  #   end
  #   # until (1..9).any? { |i| user_input.include?(i.to_s) } && user_input.to_i <= 9 && takenspaces[user_input.to_i-1] != player1_symbol && takenspaces[user_input.to_i-1] != player2_symbol do
  #   #   puts "please enter valid input (1-9), that is not taken..."
  #   #   self.user_input = gets.chomp
  #   # end
  #   user_input
  # end

  # def space_taken?(space)
  #   p takenspaces[space]
  #   @takenspaces[space] == " "
  # end

  # def player_input()
  #   if self.playerturn == self.player1_name
  #     self.player_input_backend()
  #     self.takenspaces[self.user_input.to_i-1] = self.player1_symbol
  #     self.playerturn = self.player2_name
  #     self.send_board()
  #   elsif self.playerturn == self.player2_name
  #     self.player_input_backend()
  #     self.takenspaces[self.user_input.to_i-1] = self.player2_symbol
  #     self.playerturn = self.player1_name
  #     self.send_board()
  #   else
  #     puts "There has been an error..."
  #   end
  # end

  # def send_board
  #   puts "----------------------------------------------\n #{self.takenspaces[0]} | #{self.takenspaces[1]} | #{self.takenspaces[2]}     1 | 2 | 3    #{self.player1_name} is #{self.player1_symbol}\n---+---+---   ---+---+---   #{self.player2_name} is #{self.player2_symbol}\n #{self.takenspaces[3]} | #{self.takenspaces[4]} | #{self.takenspaces[5]}     4 | 5 | 6 \n---+---+---   ---+---+---\n #{self.takenspaces[6]} | #{self.takenspaces[7]} | #{self.takenspaces[8]}     7 | 8 | 9 \n----------------------------------------------"
  #   self.has_won()
  # end

  def has_won()
    if winning_conditions.include? [player1_symbol, player1_symbol, player1_symbol]
      self.winner = self.player1_name
      self.send_winner()
      self.update_player1_score()
    elsif winning_conditions.include? [player2_symbol, player2_symbol, player2_symbol]
      self.winner = self.player2_name
      self.send_winner()
      self.update_player2_score()
    elsif self.takenspaces.none?(" ")
      self.winner = "cat"
      self.send_winner()
      self.update_cat_score()
    else
      self.player_input()
    end
  end

  def send_winner()
      puts "#{self.winner} is the winner!"
  end

  # def create_scores()
  #   @player1_scores = 0
  #   @player2_scores = 0
  #   @cat_scores = 0
  # end

  def update_player1_score()
    self.player1_scores+=1
  end

  def update_player2_score()
    self.player2_scores+=1
  end

  def update_cat_score()
    self.cat_scores+=1
  end

  def send_scoreboard()
    if self.player1_name == nil
      puts "---------------------\nNo players have been generated yet, please use the keyword start to generate players and scores\n---------------------"
    else
      puts "---------------------\nScoreboard:\n#{self.player1_name} has won #{self.player1_scores} times\n#{self.player2_name} has won #{self.player2_scores} times\nCat has won #{self.cat_scores} times\n---------------------"
    end
  end
end