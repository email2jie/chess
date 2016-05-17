require 'byebug'
require_relative 'pieces'
require_relative 'nilpiece'
class Board
  attr_reader :grid, :arr

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


  def move(start, end_pos)
    #raise exception of start.nil? or if !end_pos.nil?
    # raise StandardException => e if @grid[start].nil? || @grid[end_pos].nil?
    #   p e
    # rescue
    #   retry
    # byebug
    valid_moves = self[start].moves
    p self[start].board
    # p valid_moves
    if valid_moves.include?(end_pos)
      self[end_pos] = self[start]
      self[end_pos].position = end_pos
      p self[end_pos]
      self[start] = @nilpiece
    end
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
