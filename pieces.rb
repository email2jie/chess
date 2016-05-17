# require 'byebug'
class Pieces
  attr_reader :position, :board, :color
  NEXT_DIAG_POS = [[1,1],
                   [1,-1],
                   [-1,1],
                   [-1,-1]]
  NEXT_HV_POS = [[1,0],
                 [-1,0],
                 [0,1],
                 [0,-1]]

  def initialize(position=nil, board=nil)
    @position = position
    @board = board
  end

  def moves(direction)
      valid = valid_moves(direction)
      valid
  end

  def check_pos(arr)
    result = []
    arr.each do |pos|
      x_dif,y_dif = pos
      x,y = @position
        until !valid_range([x,y])
          x += x_dif
          y += y_dif
          pos = [x,y]
          if blocking?(pos) && @board[pos].color != self.color
            result << [x,y]
          end
          break if blocking?(pos)
          result << [x,y]
        end
      end
    result
  end

  def valid_range(pos)
    x,y = pos
    (1...7).include?(x) && (1...7).include?(y)
  end

  def valid_moves(direction)
    case direction
    when "diagonal"
      moves = check_pos(NEXT_DIAG_POS)
    when "hv"
      moves = check_pos(NEXT_HV_POS)
    when "both"
      moves = check_pos(NEXT_DIAG_POS) + check_pos(NEXT_HV_POS)
    end
    moves

  end

  def blocking?(pos)
    # pos = [x,y]
    !@board[pos].nil?
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
    " B "
  end
end

class Rook < Sliding_pieces
  def moves
    super("hv")
  end
  def to_s
    " R "
  end

end

class Queen < Sliding_pieces
  def moves
    super("both")
  end
  def to_s
    " Q "
  end

end

class King < Stepping_pieces
  def to_s
    " K "
  end
end

class Knight < Stepping_pieces
  def to_s
    " N "
  end
end
