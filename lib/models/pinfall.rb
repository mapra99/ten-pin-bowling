# frozen_string_literal: true
class Models::PinFall
  attr_reader :launches

  def initialize(launches)
    self.launches = launches
  end

  def launches=(new_launches)
    raise ArgumentError, 'No more than 3 throws per frame are allowed' if new_launches.length > 3

    sum = new_launches.inject(0) { |cum, l| cum + l.value }
    raise ArgumentError, 'The total amount of fallen pins exceeds the maximum limit' if sum > 10

    @launches = new_launches
  end

  def printable_launches
    result = Array.new(@launches.length, '')

    if @launches[0].value == 10
      result[0] = 'X'
      return result
    end

    sum = 0
    @launches.each_with_index do |launch, index|
      sum += launch.value
      if sum < 10
        result[index] = launch.value.to_s
        result[index] = '-' if launch.value.zero?
      else
        result[index] = '\\'
        return result
      end
    end

    result
  end

  def strike?
    printable_launches.include? 'X'
  end

  def spare?
    printable_launches.include? '\\'
  end
end
