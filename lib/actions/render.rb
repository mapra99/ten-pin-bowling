# frozen_string_literal: true

module Actions::Render
  def self.scoreboard(players)
    player_names = players.map(&:name)
    first_column = format_first_column(player_names)

    players_pinfalls = players.map(&:pinfalls)
    players_scores = players.map(&:scores)

    common_columns = []
    (0...9).each do |i|
      pinfalls = players_pinfalls.map { |p| p[i].printable_launches }
      score = players_scores.map { |p| p[i] }
      common_columns << format_common_frame(pinfalls, score, (i + 1).to_s)
    end

    pinfalls = players_pinfalls.map { |p| p[-1].printable_launches }
    score = players_scores.map { |p| p[-1] }

    last_column = format_last_frame(pinfalls, score, '10')

    (0...first_column.length).each do |i|
      line = first_column[i]
      line += (0...common_columns.length).inject('') do |sum, j|
        sum + common_columns[j][i]
      end
      line += last_column[i]

      puts line
    end
  end

  def self.format_first_column(names_arr)
    column_values = names_arr + %w[Frame Pinfalls Score]
    col_width = column_values.map(&:length).max + 1
    result = ['Frame'.ljust(col_width)]
    names_arr.each do |n|
      result << n.ljust(col_width)
      result << 'Pinfalls'.ljust(col_width)
      result << 'Score'.ljust(col_width)
    end

    result
  end

  def self.format_common_frame(players_pinfall, scores, index)
    first_column = [index, '']
    second_column = ['', '']
    players_pinfall.each_with_index do |p, i|
      first_column << (p.length == 2 ? p[0] : '')
      first_column << scores[i].to_s
      first_column << ''

      second_column << p[-1]
      second_column << ''
      second_column << ''
    end

    first_col_width = first_column.map(&:length).max + 1
    first_column = first_column.map { |v| v.ljust(first_col_width) }

    second_col_width = second_column.map(&:length).max + 2
    second_column = second_column.map { |v| v.ljust(second_col_width) }

    (0...first_column.length).map do |i|
      first_column[i] + second_column[i]
    end
  end

  def self.format_last_frame(players_pinfall, scores, index)
    first_column = [index, '']
    second_column = ['', '']
    third_column = ['', '']
    players_pinfall.each_with_index do |p, i|
      first_column << p[0]
      first_column << scores[i].to_s
      first_column << ''

      second_column << p[1]
      second_column << ''
      second_column << ''

      third_column << (p.length == 3 ? p[2] : '')
      third_column << ''
      third_column << ''
    end

    first_col_width = first_column.map(&:length).max + 1
    first_column = first_column.map { |v| v.ljust(first_col_width) }

    second_col_width = second_column.map(&:length).max + 1
    second_column = second_column.map { |v| v.ljust(second_col_width) }

    third_col_width = third_column.map(&:length).max + 1
    third_column = third_column.map { |v| v.ljust(third_col_width) }

    (0...first_column.length).map do |i|
      first_column[i] + second_column[i] + third_column[i]
    end
  end
end
