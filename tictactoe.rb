class TicTacToe
  attr_accessor :winner, :last_move
  # Custom setter down below
  attr_reader :board

  def initialize
    # Initialise a 3x3 board
    @board = Array.new(3, Array.new(3))

    # Last turn, either "x" or "o"
    @last_move = ""
    @turns = 0

    # Winner, either "x" or "o"
    @winner = ""
  end

  # Check if there is a winner, if yes, game is over
  def game_over?
    !winner.empty? 
  end

  # Render the current gameboard
  def render_board

    board = [["x"," ","o"],["x","o","o"],["x"," ","x"]]
    
    puts
    puts "-------------"

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
      current_player = "o"     
    when "o"
      current_player = "o"     
    else
      current_player = ["o","x"].sample      
    end

    puts "It's player #{current_player}'s turn. Make your move! [x,y]"

    self.board = gets
  end

  def board=(move)

  end
end

# Start a new game
new_game = TicTacToe.new

# Check if game is over
while !new_game.game_over? do
  # Render current board
  new_game.render_board

  # Make a move
  # new_game.make_move
end
