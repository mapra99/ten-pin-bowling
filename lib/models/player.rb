# frozen_string_literal: true

class Models::Player
  attr_accessor :name
  attr_reader :pinfalls

  def initialize(name, pinfalls)
    self.name = name
    self.pinfalls = pinfalls
  end

  def pinfalls=(new_pinfalls)
    raise ArgumentError, 'Only 10 Frames are allowed' if new_pinfalls.length != 10

    @pinfalls = new_pinfalls
  end
end
