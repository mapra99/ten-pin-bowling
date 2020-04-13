# frozen_string_literal: true

require 'byebug'
require_relative '../models/models.rb'

module Actions
  module DataImport
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
      player_names = fetch_player_names(data)
      game_players = []

      player_names.each do |p_name|
        player_data = data.select { |d| d[:name] == p_name }
        pins_counter = 0
        launches_counter = 1
        frames_counter = 1
        launches = []
        pinfalls = []

        player_data.each do |p_line|
          if(launches_counter <= 2 && frames_counter <= 9 && pins_counter <= 10) ||
            (launches_counter <= 3 && frames_counter == 10  && pins_counter <= 30)

            launches << Models::Launch.new(p_line[:value])
            launches_counter += 1
            pins_counter += launches[-1].value
          else
            byebug
            pinfalls << Models::PinFall.new(launches, frames_counter == 10)
            frames_counter += 1
            launches_counter = 1
            pins_counter = 0
            launches = []
          end
        end

      end

      game_players
    end
  end
end
