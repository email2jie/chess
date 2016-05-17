require "colorize"
require_relative 'cursorable'
# require 'byebug'

class Display
  include Cursorable
  attr_reader :cursor, :selected

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected = false

  end
  def build_grid
  @board.rows.map.with_index do |row, i|
    build_row(row, i)
  end
end

def build_row(row, i)
  row.map.with_index do |piece, j|
    color_options = colors_for(i, j, piece)
    # byebug
    piece.to_s.encode('utf-8').colorize(color_options)
  end
end

def colors_for(i, j, piece)
  if [i, j] == @cursor_pos
    bg = :light_red
  elsif (i + j).odd?
    bg = :blue
  else
    bg = :light_blue
  end
  { background: bg, color: piece.color }
end

def render
  # system("clear")
  puts "Fill the grid!"
  puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
  p @cursor_pos
  build_grid.each { |row| puts row.join }
end
end
