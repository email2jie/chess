require_relative 'pieces'
require_relative 'nilpiece'
class Board
  attr_reader :grid, :arr

  def initialize(grid=empty_grid)
    @grid = grid

  end

  def not_pawns(color)
    @arr << Rook.new(color)
    @arr << Knight.new(color)
    @arr << Bishop.new(color)
    @arr << Queen.new(color)
    @arr << King.new(color)
    @arr << Bishop.new(color)
    @arr << Knight.new(color)
    @arr << Rook.new(color)

  end

  def empty_grid
    @arr = []
    not_pawns(:black)
    not_pawns(:white)
    nilpiece = Nilpiece.instance
    grid = Array.new(8) { Array.new(8) }
    grid.each_with_index do |row, idx|
      row.each_with_index do |el, idy|
        if idx < 1 || idx > 6
          grid[idx][idy] = @arr.shift
          grid[idx][idy].position = [idx,idy]
        else
          grid[idx][idy] = nilpiece
        end
      end
    end
  end

  def in_bounds?(pos)
     pos.all? { |x| x.between?(0, 7) }
  end


  def move(start, end_pos)
    #raise exception of start.nil? or if !end_pos.nil?
    raise StandardException => e if @grid[start].nil? || @grid[end_pos].nil?
      p e
    rescue
      retry

  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    @grid[pos] = value
  end
  def rows
    @grid
  end
end
