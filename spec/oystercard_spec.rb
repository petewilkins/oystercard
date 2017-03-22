require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {double :journey}

  describe "#initialze" do
    it "has balance of zero" do
      expect(oystercard.balance).to eq(0)
    end

    it "has an empty array by default" do
      expect(oystercard.journey_history).to be_empty
    end
  end

  describe "#top_up" do
    it "adds to balance" do
      expect{ oystercard.top_up 20}.to change{ oystercard.balance }.by 20
    end

    it "raises error if limit exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{ oystercard.top_up 1 }.to raise_error "Top up unsuccessful: Balance cannot exceed £#{maximum_balance}."
    end
  end

  describe "#touch_in" do
    it "raises error if below minimum balance" do
      expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds: Please top-up."
    end
  end

  context "#journey_history" do
    it "stores a journey in history" do
      allow(journey).to receive(:start)
      allow(journey).to receive(:finish)

      #      plane = double(:plane, flying?: true)

      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journey_history.length).to eq 1
    end
  end
end
