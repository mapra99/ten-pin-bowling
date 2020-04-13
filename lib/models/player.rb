# frozen_string_literal: true

class Models::Player
  attr_accessor :name
  attr_reader :pinfalls

  def initialize(name=nil, pinfalls=nil)
    self.name = name
    self.pinfalls = pinfalls
  end

  def pinfalls=(new_pinfalls)
    raise ArgumentError, 'Only 10 Frames are allowed' if new_pinfalls&.length != 10

    @pinfalls = new_pinfalls
  end

  def scores
    result = Array.new 10, 0

    pinfalls.each_with_index do |p, i|
      if p.strike? && i < 8
        result[i] = if pinfalls[i + 1].strike?
                      10 + pinfalls[i + 1].launches[0].value + pinfalls[i + 2].launches[0].value + result[i - 1]
                    else
                      10 + pinfalls[i + 1].launches.inject(0) { |s, l| s + l.value } + result[i - 1]
                    end
      elsif p.strike? && i == 8
        result[i] = 10 + pinfalls[i + 1].launches[0].value + pinfalls[i + 1].launches[1].value + result[i - 1]
      elsif p.spare? && i < 9
        result[i] = 10 + pinfalls[i + 1].launches[0].value + result[i - 1]
      else
        result[i] = p.launches.inject(0) { |s, l| s + l.value } + result[i - 1]
      end
    end

    result
  end
end
