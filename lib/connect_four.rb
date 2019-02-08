class ConnectFour
  attr_reader :players, :turn, :win_condition

  def initialize
    @players = { player1: "\u2620", player2: "\u2622" }
    @gameboard = create_board
    @turn = %w(player1 player2)
    @win_condition = false
  end

  def take_turn
    move = gets.chomp
    until valid_move?(move) do
      puts "Enter the row you would like to drop your piece: "
    end
    add_to_board(move.to_i)
    change_turn
  end

  def clear_screen
    system('cls')
  end

  private

  def create_board
    board = [
        %w| - - - - - - - |,
        %w| - - - - - - - |,
        %w| - - - - - - - |,
        %w| - - - - - - - |,
        %w| - - - - - - - |,
        %w| - - - - - - - |
    ]
  end

  def change_turn
    @turn.reverse!
  end

  def valid_move?(input)
    num = input.to_i
    return false unless (1..7).include?(num)
    return true if @gameboard[5][num] == "-"
    false
  end

  def show_board
    puts %Q(0 1 2 3 4 5 6 )
    @gameboard.each do |board|
      board.each { |space| print "#{space} " }
      print "\n"
    end
  end

  def add_to_board(column)
    row = 0
    @gameboard.each do |piece|
      if piece[column] == "-"
        piece[column] = @players[@turn[0].to_sym]
        break
      end
      row += 1
    end
    check_connect_four(row, column)
  end

  def check_connect_four(row, column)
    if check_horizontal(row, column) || check_vertical(row, column) || check_diagonal(row, column)
      end_game
    end
  end

  def check_horizontal(row, column)
    count = 1
    piece_count = 1
    until @gameboard[row][column + count].nil?
      if @gameboard[row][column + count] == @players[@turn[0].to_sym]
        count += 1
        piece_count += 1
        @gameboard[row][column + count].nil? ? break : next
      else
        break
      end
    end
    until column - count < 0
      if @gameboard[row][column - count] == @players[@turn[0].to_sym]
        count += 1
        piece_count += 1
        next
      else
        break
      end
    end
    return true if piece_count >= 4
    false
  end

  def check_vertical(row, column)
    count = 1
    piece_count = 1
    until @gameboard[row + count].nil?
      if @gameboard[row + count][column] == @players[@turn[0].to_sym]
        count += 1
        piece_count += 1
        @gameboard[row + count].nil? ? break : next
      else
        break
      end
    end
    until row - count < 0
      if @gameboard[row - count][column] == @players[@turn[0].to_sym]
        count += 1
        piece_count += 1
        next
      else
        break
      end
    end
    return true if piece_count >= 4
    false
  end
  def check_diagonal(row, column)
    count = 1
    piece_count = 1
    until @gameboard[row + count][column + count].nil? do
      if @gameboard[row + count][column + count] == @players[@turn[0].to_sym]
        count += 1
        piece_count += 1
        @gameboard[row + count].nil? ? break : next
      else
        break
      end
    end
    return true if piece_count >= 4
    false
  end

  def end_game
    puts "#{@turn[0].capitalize} wins! Press ENTER to exit."
    gets
    exit
  end
end
