require 'journey_log'

describe JourneyLog do
  subject(:journeylog) { described_class.new }
  let(:station) {double :station}


  describe '#initialze' do
    it 'sets to Journey by default' do
      expect(journeylog.journey_class).to eq Journey
    end

    it 'creates an empty journey history' do
      expect(journeylog.journey_history).to eq []
    end
  end

  describe '#begin' do
    it 'creates a new journey' do
      journey = journeylog.begin(station)
      expect(journeylog.journey_history).to include journey
    end
  end

  describe '#end' do
    it 'adds exit station to current journey' do
      journeylog.begin(station)
      journeylog.end(station)
      expect(journeylog.journey_history.pop.current_trip).to eq ({station => station})
    end
  end

  describe '#journeys' do
    it 'should return a list of previous journeys' do
      3.times {
        journeylog.begin(station)
        journeylog.end(station)
      }
      expect(journeylog.journeys).to eq journeylog.journey_history
    end
  end

  # describe '#current_journey' do
  #   it 'creates a new journey if none exists' do
  #     expect(journeylog.journey_class).to receive(:new)
  #     journeylog.current_journey
  #   end
  #   it 'returns an incomplete journey' do
  #     journey = journeylog.begin(station)
  #     expect(journeylog.current_journey).to eq journey
  #   end

  #end
end
