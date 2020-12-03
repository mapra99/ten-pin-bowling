# frozen_string_literal: true

require_relative '../lib/models/launch.rb'
require_relative '../lib/models/pinfall.rb'
require_relative '../lib/models/player.rb'

require_relative '../lib/actions/data_lib.rb'
require_relative '../lib/actions/render.rb'

file_path = ARGV[0]
data = Actions::DataLib.load_data file_path
players = Actions::DataLib.process_data data
Actions::Render.scoreboard players