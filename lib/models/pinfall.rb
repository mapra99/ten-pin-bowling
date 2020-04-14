# frozen_string_literal: true

class Models::PinFall
  attr_reader :launches
  attr_accessor :last_frame

  def initialize(launches, last_frame = false)
    @last_frame = last_frame
    self.launches = launches
  end

  def launches=(new_launches)
    raise ArgumentError, 'No more than 3 throws per frame are allowed' if new_launches.length > 3

    sum = new_launches.inject(0) { |cum, l| cum + l.value }
    raise ArgumentError, 'The total amount of fallen pins exceeds the maximum limit' if sum > 10 && !last_frame
    raise ArgumentError, 'The total amount of fallen pins exceeds the maximum limit' if sum > 30 && last_frame

    @launches = new_launches
  end

  def printable_launches
    if last_frame
      printable_last_launches
    else
      printable_common_launches
    end
  end

  def strike?
    printable_launches.include? 'X'
  end

  def spare?
    printable_launches.include? '/'
  end

  private

  def printable_last_launches
    result = Array.new(@launches.length, '')
    sum = 0
    @launches.each_with_index do |launch, index|
      sum += launch.value
      result[index] = launch.value.to_s
      result[index] = '/' if sum == 10
    end

    result
  end

  def printable_common_launches
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
      else
        result[index] = '/'
        return result
      end
    end

    result
  end
end
