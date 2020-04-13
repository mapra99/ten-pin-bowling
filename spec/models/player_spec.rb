# frozen_string_literal: true

require_relative '../../lib/models/models.rb'

RSpec.describe Models::Player do
  context 'validations' do
    it 'raises an error if more than ten pinfalls are received' do
      pinfalls = []
      11.times do
        pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('5')])
      end

      expect { Models::Player.new('Jeff', pinfalls) }.to raise_error ArgumentError
    end

    it 'raises an error if less than ten pinfalls are received' do
      pinfalls = []
      9.times do
        pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('5')])
      end

      expect { Models::Player.new('Jeff', pinfalls) }.to raise_error ArgumentError
    end

    it 'continues if ten pinfalls are received' do
      pinfalls = []
      10.times do
        pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('5')])
      end

      expect { Models::Player.new('Jeff', pinfalls) }.not_to raise_error ArgumentError
    end
  end
end
