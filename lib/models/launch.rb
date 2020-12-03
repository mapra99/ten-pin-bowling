# frozen_string_literal: true
module Models
  class Launch
    attr_reader :value

    def initialize(value)
      self.value = value
    end

    def value=(gross_value)
      raise ArgumentError, 'Invalid Pinfall value' unless gross_value.match?(/^([0-9]*|F)$/)

      if gross_value == 'F'
        @value = 0
      elsif (0..10).include? gross_value.to_i
        @value = gross_value.to_i
      else
        raise ArgumentError, 'Invalid Pinfall value'
      end
    end
  end
end
