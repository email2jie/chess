require_relative "board"
require_relative "display"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def run
    puts "Mark all the spaces on the board!"
    puts "WASD or arrow keys to move the cursor, enter or space to confirm."
    until false


      @display.render
      pos = @display.get_input
      # @board.mark(pos)
    end
    puts "Hooray, the board is filled!"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end
