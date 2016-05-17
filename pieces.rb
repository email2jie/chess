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
      x,y = @position
      pos.each do |x_dif, y_dif|
        until blocking?(x,y) || !valid_range([x,y])
          pos = [x,y]
          break if @board[pos]
          x += x_dif
          y += y_dif
          result << [x,y]
          pos = [x,y]
          if blocking?(x,y) && @board[pos].color != self.color
            result << [x,y]
          end
        end
      end
    end
    result
  end
  #
  # def check_diagonals
  #   diagonal = []
  #   NEXT_DIAG_POS.each do |pos|
  #     x,y = @position
  #     pos.each do |x_dif, y_dif|
  #       until blocking?(x,y) || !valid_range([x,y])
  #         x += x_dif
  #         y += y_dif
  #         diagonal << [x,y]
  #         if blocking?(x,y) && @board[[x,y]].color != self.color
  #           diagonal << [x,y]
  #         end
  #       end
  #     end
  #   end
  #   diagonal
  # end

  def valid_range(pos)
    x,y = pos
    (0...8).include?(x) && (0...8).include?(y)
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

  def blocking?(x,y)
    pos = [x,y]
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
  def move_dirs
    direction = "diagonal"
    moves = moves(direction)
    moves
  end
end

class Rook < Sliding_pieces
  def move_dirs
  end

end

class Queen < Sliding_pieces

end

class King < Stepping_pieces
end

class Knight < Stepping_pieces
end
