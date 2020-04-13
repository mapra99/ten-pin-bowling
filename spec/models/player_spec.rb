# frozen_string_literal: true

require_relative '../../lib/models/models.rb'

RSpec.describe Models::Player do
  context 'frames validations' do
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

      expect { Models::Player.new('Jeff', pinfalls) }.not_to raise_error
    end
  end

  context 'score computation for cases with no strike or spares' do
    before :example do
      @pinfalls = []
      10.times do
        @pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('4')])
      end
      @pinfalls[-1].last_frame = true
    end

    it 'returns the score for frames with no strikes or spares' do
      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 64, 72, 80]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with faults' do
      @pinfalls[0] = Models::PinFall.new([Models::Launch.new('F'), Models::Launch.new('8')])
      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 64, 72, 80]

      expect(p.scores).to eq(expected_result)
    end
  end

  context 'score coputation for cases with strike' do
    before :example do
      @pinfalls = []
      10.times do
        @pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('4')])
      end

      @pinfalls[-1].last_frame = true
    end

    it 'returns the score for frames with one strike a the begining' do
      @pinfalls[0] = Models::PinFall.new([Models::Launch.new('10')]) # first launch was a strike

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [18, 26, 34, 42, 50, 58, 66, 74, 82, 90]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with three continuous strikes at the begining' do
      @pinfalls[0] = Models::PinFall.new([Models::Launch.new('10')]) # first launch was a strike
      @pinfalls[1] = Models::PinFall.new([Models::Launch.new('10')]) # second launch was a strike
      @pinfalls[2] = Models::PinFall.new([Models::Launch.new('10')]) # third launch was a strike

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [30, 54, 72, 80, 88, 96, 104, 112, 120, 128]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with three continuous strikes at the end' do
      @pinfalls[-1] = Models::PinFall.new([Models::Launch.new('10'), Models::Launch.new('10'), Models::Launch.new('10')], true) # tenth launch was a full strike
      @pinfalls[-2] = Models::PinFall.new([Models::Launch.new('10')]) # ninth launch was a strike
      @pinfalls[-3] = Models::PinFall.new([Models::Launch.new('10')]) # eighth launch was a strike

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 86, 116, 146]

      expect(p.scores).to eq(expected_result)
    end
  end

  context 'score computation for cases with spares' do
    before :example do
      @pinfalls = []
      10.times do
        @pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('4')])
      end
    end

    it 'returns the score for frames with one spare' do
      @pinfalls[0] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # first launch was a spare

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [14, 22, 30, 38, 46, 54, 62, 70, 78, 86]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with three continuous spares at start' do
      @pinfalls[0] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # first launch was a spare
      @pinfalls[1] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # second launch was a spare
      @pinfalls[2] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # third launch was a spare

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [12, 24, 38, 46, 54, 62, 70, 78, 86, 94]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with three continuous spares at the end' do
      @pinfalls[-1] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8'), Models::Launch.new('2')], true) # tenth launch was a spare
      @pinfalls[-2] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # ninth launch was a spare
      @pinfalls[-3] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # eighth launch was a spare

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 68, 80, 92]

      expect(p.scores).to eq(expected_result)
    end
  end

  context 'score computation for mixed cases' do
    before :example do
      @pinfalls = []
      10.times do
        @pinfalls << Models::PinFall.new([Models::Launch.new('4'), Models::Launch.new('4')])
      end

      @pinfalls[-1].last_frame = true
    end

    it 'returns the score for frames with strike - spare - strike' do
      @pinfalls[0] = Models::PinFall.new([Models::Launch.new('10')]) # first launch was a strike
      @pinfalls[1] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')]) # second launch was a spare
      @pinfalls[2] = Models::PinFall.new([Models::Launch.new('10')]) # third launch was a strike

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [20, 40, 58, 66, 74, 82, 90, 98, 106, 114]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with strike - spare at the last frame' do
      @pinfalls[-1] = Models::PinFall.new([Models::Launch.new('10'), Models::Launch.new('2'), Models::Launch.new('8')], true)

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 64, 72, 92]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with spare - strike at the last frame' do
      @pinfalls[-1] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8'), Models::Launch.new('10')], true)

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 64, 72, 92]

      expect(p.scores).to eq(expected_result)
    end

    it 'returns the score for frames with spare - strike at the last two frames' do
      @pinfalls[-1] = Models::PinFall.new([Models::Launch.new('10'), Models::Launch.new('10'), Models::Launch.new('10')], true)
      @pinfalls[-2] = Models::PinFall.new([Models::Launch.new('2'), Models::Launch.new('8')])

      p = Models::Player.new('Jeff', @pinfalls)
      expected_result = [8, 16, 24, 32, 40, 48, 56, 64, 84, 114]

      expect(p.scores).to eq(expected_result)
    end
  end
end
