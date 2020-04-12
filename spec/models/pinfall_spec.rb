# frozen_string_literal: true
require_relative '../../lib/models/models.rb'

RSpec.describe Models::PinFall do
  context 'input validations' do
    it 'raises an error if more than 3 launches are sent as input' do
      launches = []
      4.times do
        launches << Models::Launch.new('2')
      end

      expect { Models::PinFall.new(launches) }.to raise_error ArgumentError
    end

    it 'continues if 3 or less launches are sent as input' do
      launches = []
      2.times do
        launches << Models::Launch.new('2')
      end

      expect { Models::PinFall.new(launches) }.not_to raise_error ArgumentError
    end

    it 'raises an error if the total amount of fallen pins is not valid' do
      launches = [Models::Launch.new('9'), Models::Launch.new('9')] # 18 pins in total

      expect { Models::PinFall.new(launches) }.to raise_error ArgumentError
    end

    it 'continues an error if the total amount of fallen pins is valid' do
      launches = [Models::Launch.new('4'), Models::Launch.new('5')] # 9 pins in total

      expect { Models::PinFall.new(launches) }.not_to raise_error ArgumentError
    end
  end

  context 'handle pinfall values' do
    it 'returns a printable X for a launch where strike was achieved' do
      launch_one = Models::Launch.new '10'
      pinfall = Models::PinFall.new([launch_one])

      expect(pinfall.printable_launches).to eq(['X'])
    end

    it 'returns a printable \ for a launch where spare was achieved' do
      launch_one = Models::Launch.new '3'
      launch_two = Models::Launch.new '7'
      pinfall = Models::PinFall.new([launch_one, launch_two])

      expect(pinfall.printable_launches).to eq(['3', '\\'])
    end

    it 'returns a printable pin fall amount for a launch where neither strike nor spare was achieved' do
      launch_one = Models::Launch.new '3'
      launch_two = Models::Launch.new '5'
      pinfall = Models::PinFall.new([launch_one, launch_two])

      expect(pinfall.printable_launches).to eq(%w[3 5])
    end

    it 'returns a printable - for a launch where 0 pins were knocked down' do
      launch_one = Models::Launch.new '0'
      launch_two = Models::Launch.new 'F'
      pinfall = Models::PinFall.new([launch_one, launch_two])

      expect(pinfall.printable_launches).to eq(%w[- -])
    end
  end

  context 'define wether a strike o spare was achieved' do
    it 'returns true if a strike was achieved' do
      launch_one = Models::Launch.new '10'
      pinfall = Models::PinFall.new([launch_one])

      expect(pinfall.strike?).to be true
    end

    it 'returns true if a spare was achieved' do
      launch_one = Models::Launch.new '1'
      launch_two = Models::Launch.new '9'
      pinfall = Models::PinFall.new([launch_one, launch_two])

      expect(pinfall.spare?).to be true
    end

    it 'returns false if neither spare nor strike was achieved' do
      launch_one = Models::Launch.new '1'
      launch_two = Models::Launch.new '5'
      pinfall = Models::PinFall.new([launch_one, launch_two])

      expect(pinfall.strike?).to be false
      expect(pinfall.spare?).to be false
    end
  end
end
