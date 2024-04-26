class TicTacToe
  attr_accessor :winner, :last_move, :current_player, :turns
  attr_reader :board

  def initialize
    # Initialise a 3x3 board
    @board = Array.new(3) { [" "," "," "] }

    # Last turn, either "x" or "o"
    @last_move = ""
    @turns = 0

    @current_player = ""

    # Winner, either "x" or "o"
    @winner = ""
  end

  # Check if there is a winner, if yes, game is over
  def game_over?
    if winner.empty?
      return false
    else
      return true
    end
  end

  # Render the current gameboard
  def render_board

    puts "Turns: #{turns}"
    puts
    puts " -------------"

    board.each do |row|
      puts "| #{row[0]} | #{row[1]} | #{row[2]} |"
      puts "-------------"
    end

    puts
  end

  # Make a move as either "x" or "o"
  def make_move
    # Check who made the last move
    # If no previous moves, choose randomly
    case last_move
    when "x"
      self.current_player = "o"     
    when "o"
      self.current_player = "x"     
    else
      self.current_player = ["o","x"].sample      
    end

    puts "It's player #{current_player}'s turn. Make your move by entering two numbers: x,y"

    move_done = false
    while !move_done do

      # Get input
      input = gets

      # Validate input
      position = parse_input(input)

      unless position.empty?
        # Check if move can be done (array position is " ")
        if move_allowed?(position)
          # Make move by updating the array
          update_board(position)

          self.turns += 1
          # Update last move
          self.last_move = current_player

          # Check if this was a winning move?
          self.winner = winning_move?

          # Set move as made
          move_done = true
        end
      end
    end
  end
  
  def congratulate
    unless turns == 9
      puts "#{winner} has won the game after #{turns} moves! Yeah!"
    else
      puts "It's a tie! Great match!"
    end
  end
  
  private
  # Check if the move has won the game
  def winning_move?
    # Check rows
    board.each do |row|
      if row.all? { |e| e == current_player }
        return current_player
      end
    end

    # Check diagonals
    board.transpose.each do |column|
      if column.all? { |e| e == current_player }
        return current_player
      end
    end

    # Check diagonals
    diagonal1 = [ board[0][0], board[1][1], board[2][2] ]
    diagonal2 = [ board[2][0], board[1][1], board[0][2] ]

    if diagonal1.all? { |e| e == current_player } || diagonal2.all? { |e| e == current_player }
      return current_player
    end

    return ""
  end
  
  # Parses user input, which has to translate into an array of two numbers
  # If successful, returns an array of 2 numbers between 1,3
  # If not, returns empty string
  def parse_input(input)
    # Get rid of whitespace and turn to integers
    output = input.split(",")
    output.map! { |element| element.strip.to_i }

    # Check numbers are between 1 and 3, if yes, return true
    if output.is_a?(Array) && output.size == 2 && output.all? { |element| element.between?(1,3) }
      return output
    else
      puts "You need to enter two numbers between 1 and 3!"
      return ""
    end
  end

  # Checks if the given board position is empty, meaning value of " "
  # If yes, returns true, meaning a move can be made there
  def move_allowed?(position)
    # board = [["x"," ","o"],["x","o","o"],["x"," ","x"]]
    if board[position[0] - 1][position[1] - 1] == " "
      return true
    else
      puts "You cannot move there! There's already a #{board[position[0] - 1][position[1] - 1]} there!"
      return false
    end
  end

  # Update the board
  def update_board(position)
    board[position[0] - 1][position[1] - 1] = current_player
  end

end

new_game = TicTacToe.new

while !new_game.game_over? do
  # Render current board
  new_game.render_board

  # Make a move
  new_game.make_move

  if new_game.game_over? 
    new_game.congratulate

    new_game.render_board
  end
end
