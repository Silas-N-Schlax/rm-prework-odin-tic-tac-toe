# Generates player
class Players
  attr_accessor :name, :symbol, :score

  def initialize(name = player_name, symbol = set_symbol, score = 0)
    @name = name
    @symbol = symbol
    @score = score
  end

  def set_player_name
    puts "\nPlayer please enter your name..."
    gets.chomp
  end

  def set_symbol
    puts "#{@name} has been created, please enter the symbol you would like to use..."
    gets.chomp.chars.first
  end
end
