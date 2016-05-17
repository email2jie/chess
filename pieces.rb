require 'byebug'
class Pieces
  attr_accessor :board
  attr_reader :position, :color
  NEXT_DIAG_POS = [[1,1],
                   [1,-1],
                   [-1,1],
                   [-1,-1]]
  NEXT_HV_POS = [[1,0],
                 [-1,0],
                 [0,1],
                 [0,-1]]
  NEXT_KNIGHT_POS = [[-2,1],
             [-1,2],
             [1,2],
             [2,1],
             [2,-1],
             [1,-2],
             [-1,-2],
             [-2,-1]]

  def initialize(color=nil, board=nil, position=nil)
    @color = color
    @position = position
    @board = board
  end

  def position=(arr)
    @position = arr
  end

  def moves(direction)
    valid_moves(direction)
  end

  def check_step_pos(arr)
    result = []
    arr.each do |pos|
      x_dif,y_dif = pos
      x,y = @position

          x += x_dif
          y += y_dif
          pos = [x,y]
          if blocking?(pos) && @board[pos].color != self.color
            result << pos
          end

          result << pos if valid_range(pos)

      end
    result
  end

  def check_pos(arr)
    result = []
    arr.each do |pos|
      x_dif,y_dif = pos
      x,y = @position

        loop do
          x += x_dif
          y += y_dif
          pos = [x,y]
          break unless valid_range(pos)
          # byebug if x_dif ==1 && y_dif ==1
          if blocking?(pos) && @board[pos].color != self.color
            result << pos
          end
          break if blocking?(pos)
          result << pos
        end
      end
      p result
    result
  end

  def valid_range(pos)
    x,y = pos
    (0..7).include?(x) && (0..7).include?(y)
  end

  def valid_moves(direction)
    case direction
    when "diagonal"
      moves = check_pos(NEXT_DIAG_POS)
    when "hv"
      moves = check_pos(NEXT_HV_POS)
    when "both"
      moves = check_pos(NEXT_DIAG_POS) + check_pos(NEXT_HV_POS)
    when "knight"
      moves = check_step_pos(NEXT_KNIGHT_POS)
    when "king"
      moves = check_step_pos(NEXT_DIAG_POS) + check_step_pos(NEXT_HV_POS)
    end
    moves

  end

  def blocking?(pos)
    # pos = [x,y]
    !@board[pos].is_a?(Nilpiece)
  end

end

class Sliding_pieces < Pieces
  def moves(direction)
      super(direction)
  end
end

class Stepping_pieces < Pieces
  def moves(direction)
      super(direction)
  end
end

class NullPiece < Pieces

end

class Bishop < Sliding_pieces
  def moves
    super("diagonal")
  end
  def to_s
    " \u2657  "
  end
end

class Rook < Sliding_pieces
  def moves
    super("hv")
  end
  def to_s
    " \u2656  "
  end
end

class Queen < Sliding_pieces
  def moves
    super("both")
  end
  def to_s
    " \u2655  "
  end

end

class King < Stepping_pieces
  def moves
    super("king")
  end
  def to_s
    " \u2654  "
  end
end

class Knight < Stepping_pieces
  def moves
    super("knight")
  end
  def to_s
    " \u2658  "
  end
end
