require 'byebug'
require_relative 'pieces'
require_relative 'nilpiece'
class Board
  attr_reader :grid, :arr, :white_remaining, :black_remaining

  def initialize(grid=empty_grid)
    @grid = grid
  end

  def not_pawns(color)
    @arr << Rook.new(color, self)
    @arr << Knight.new(color, self)
    @arr << Bishop.new(color, self)
    @arr << Queen.new(color, self)
    @arr << King.new(color, self)
    @arr << Bishop.new(color, self)
    @arr << Knight.new(color, self)
    @arr << Rook.new(color, self)
  end

  def empty_grid
    @arr = []
    not_pawns(:black)
    not_pawns(:white)
    # @black_remaining = @arr.select { |piece| piece.color == :black }
    # @white_remaining = @arr.select { |piece| piece.color == :white }
    @nilpiece = Nilpiece.instance
    grid = Array.new(8) { Array.new(8) }
    grid.each_with_index do |row, idx|
      row.each_with_index do |el, idy|
        if idx < 1 || idx > 6
          grid[idx][idy] = @arr.shift
          grid[idx][idy].position = [idx,idy]
        else
          grid[idx][idy] = @nilpiece
        end
      end
    end
  end

  def in_bounds?(pos)
     pos.all? { |x| x.between?(0, 7) }
  end

  def in_check?(color)
    #run through the grid, add all pieces except the king into their
    #appropriate colors, save the pos of the color king
    king_pos = nil
    other_valid_moves = []
    @white_remaining = []
    @black_remaining = []
    grid.flatten.each do |piece|
      @white_remaining << piece if piece.color == :white
      @black_remaining << piece if piece.color == :black
    end
    if color == :white
      @black_remaining.each do |el|
        if el.is_a?(King)
          king_pos = el.position
        end
      end
      return @white_remaining.any? do |piece|
        piece.moves.include?(king_pos)
      end
    else
      @white_remaining.each do |el|
        if el.is_a?(King)
          king_pos = el.position
        end
      end
      return @black_remaining.any? do |piece|
        piece.moves.include?(king_pos)
      end
    end
    #run through the pieces of the opponents color to see if == to king's
  end

  def in_checkmate?(color)
      if color == :white
        p @white_remaining.all? do |el|
          el.moves.count == 0
        end
      else
        p @black_remaining.all? do |el|
          el.moves.count == 0
        end
      end
  end



  def move(start, end_pos)
    #raise exception of start.nil? or if !end_pos.nil?
    # raise StandardException => e if @grid[start].nil? || @grid[end_pos].nil?
    #   p e
    # rescue
    #   retry
    # byebug
    valid_moves = self[start].moves
    if valid_moves.include?(end_pos)
      self[end_pos] = self[start]
      self[end_pos].position = end_pos
      self[start] = @nilpiece
    end
    in_checkmate?(self.color)

  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  def rows
    @grid
  end
end
