require 'journey_log'

describe JourneyLog do
  subject(:journeylog) { described_class.new }
  let(:station) {double :station}


  describe '#initialze' do
    it 'sets to Journey by default' do
      expect(journeylog.journey_class).to eq Journey
    end
  end

  describe '#start' do
    it 'creates a new journey' do
      expect(journeylog.journey_class).to receive(:new)
      journeylog.start(station)
    end
  end

end
