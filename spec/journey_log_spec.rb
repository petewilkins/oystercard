require 'journey_log'

describe JourneyLog do
  subject(:journeylog) { described_class.new }
  let(:station) {double :station}


  describe '#initialze' do
    it 'sets to Journey by default' do
      expect(journeylog.journey_class).to eq Journey
    end

    it 'creates an empty journey history' do
      expect(journeylog.journeys).to eq []
    end
  end

  describe '#start' do
    it 'creates a new journey' do
      expect(journeylog.journey_class).to receive(:new)
      journeylog.start(station)
    end
  end

  describe '#current_journey' do
    it 'creates a new journey if none exists' do
      expect(journeylog.journey_class).to receive(:new)
      journeylog.current_journey
    end
    it 'returns an incomplete journey' do
      journey = journeylog.start(station)
      expect(journeylog.current_journey).to eq journey
    end

  end
end
