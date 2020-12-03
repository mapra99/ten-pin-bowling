# frozen_string_literal: true

module Actions
  module DataLib
    def self.load_data(file_path)
      raw_data = File.open(file_path, 'r').read
      raw_data = raw_data.split("\n")

      raw_data.map do |line|
        values = line.split('\\t')
        { name: values[0],
          value: values[1] }
      end
    end

    def self.fetch_player_names(data)
      require 'set'
      Set.new(data.map { |d| d[:name] })
    end

    def self.process_data(data)
      players = {}
      launches = []
      current_name = data[0][:name]
      data.each do |d|
        players[d[:name]] ||= []

        if current_name == d[:name]
          launches << Models::Launch.new(d[:value])
        else
          players[current_name] << Models::PinFall.new(launches, players[d[:name]].length == 9)
          launches = [Models::Launch.new(d[:value])]
          current_name = d[:name]
        end
      end
      players[current_name] << Models::PinFall.new(launches, players[data[-1][:name]].length == 9)

      players.map do |name, pinfalls|
        Models::Player.new name, pinfalls
      end
    end
  end
end
