# frozen_string_literal: true

class Models::Launch
  attr_reader :value

  def initialize(value)
    self.value = value
  end

  def value=(gross_value)
    raise ArgumentError, 'Invalid Pinfall value' unless gross_value.match?(/^([0-9]*|F)$/)

    if gross_value == 'F'
      @value = gross_value
    elsif (0..10).include? gross_value.to_i
      @value = gross_value.to_i
    else
      raise ArgumentError, 'Invalid Pinfall value'
    end
  end
end