require 'journey_log'

describe JourneyLog do
  subject(:journeylog) { described_class.new }

  describe '#initialze' do
    it 'sets to Journey by default' do
      expect(journeylog.journey_class).to eq Journey
    end
  end
end
