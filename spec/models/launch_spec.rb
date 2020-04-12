# frozen_string_literal: true

require_relative '../../lib/models/models.rb'

RSpec.describe Models::Launch do
  it 'returns true for a valid input' do
    valid_pinfalls = %w[0 1 2 3 4 5 6 7 8 9 10 F]

    valid_pinfalls.each do |p|
      expect { Models::Launch.new(p) }.not_to raise_error ArgumentError
    end
  end

  it 'returns false for an invalid input' do
    invalid_pinfalls = %w[-1]

    invalid_pinfalls.each do |p|
      expect { Models::Launch.new(p) }.to raise_error ArgumentError
    end
  end
end
