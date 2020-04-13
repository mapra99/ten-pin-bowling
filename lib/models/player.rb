# frozen_string_literal: true

class Models::Player
  attr_accessor :name
  attr_accessor :pinfalls

  def initialize(name, pinfalls)
    @name = name
    @pinfalls = pinfalls
  end
end
