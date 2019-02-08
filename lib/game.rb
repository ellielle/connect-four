require_relative "connect_four"

class Game
  def initialize
    @game = ConnectFour.new
    start_game
  end

  private

  def start_game
    print_rules
    until @game.win_condition do
      puts "#{@game.turn[0].capitalize}'s turn."
      puts "Enter the row you would like to drop your piece: "
      @game.take_turn
    end
  end

  def print_rules
    @game.clear_screen
    puts <<~RULES
    Welcome to Connect Four! Each player will take turns dropping their piece
    into a slot on the board. The first player to have 4 pieces in a row
    horizontally, vertically or diagonally wins.\n
    RULES
  end
end

run = Game.new
