require 'pry'

class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i
    index -= 1
    index
  end

  def move(index, player_token)
    @board[index] = player_token
  end

  def position_taken?(index)
    @board[index] != " "? true : false
  end

  def valid_move?(index)
    (!position_taken?(index) && index >= 0 && index <= 8)? true : false
  end

  def turn_count
    @board.select{|position| position != " "}.count
  end

  def current_player
    turn_count.even?? "X" : "O"
  end

  def turn
    puts "Player #{current_player}, please pick a position to move (1-9):"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Invalid move."
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.detect{|combo| (@board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]]) && @board[combo[0]] != " "}
  end

  def full?
    turn_count == 9
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    @board[won?[0]] if won?
  end

  def play
    if !over?
      turn
      play
    elsif won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
