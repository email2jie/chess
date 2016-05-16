require_relative 'pieces'

class Board
  attr_reader :grid

  def initialize(grid=empty_grid)
    @grid = grid

  end

  def empty_grid
    grid = Array.new(8) { Array.new(8) }
    grid.each_with_index do |row, idy|
      row.each_with_index do |el, idx|
        if idy <= 1 || idy >= 6
          grid[idy][idx] = Pieces.new
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
