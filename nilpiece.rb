require 'singleton'
class Nilpiece
  include Singleton
  attr_reader :color
  def to_s
    return "   "
  end
end
