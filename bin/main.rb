# frozen_string_literal: true

require_relative '../lib/models/models.rb'
require_relative '../lib/actions/actions.rb'

file_path = ARGV[0]
data = Actions::DataLib.load_data file_path
players = Actions::DataLib.process_data data
Actions::Render.scoreboard players