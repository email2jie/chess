class Pieces
  attr_reader :position, :board

  def initialize(position=nil, board=nil)
    @position = position
    @board = board
  end

  def moves

  end

end

class Sliding_pieces < Pieces

  def moves(direction)
  end
end

class Stepping_pieces < Pieces
end

class NullPiece < Pieces
end
