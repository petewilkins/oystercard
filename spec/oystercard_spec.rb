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

  context "#journeys" do
    before do
      oystercard.top_up(50)
    end

    it "expects card to not be in journey by default" do
      expect(oystercard).to_not be_in_journey
    end

    it "expects card to be in journey once touched in" do
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it "expects card not to be in journey once journey is completed" do
      entry_station = double("station", :zone => 1)
      exit_station = double("station", :zone => 4)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard).to_not be_in_journey
    end

    it "expects penalty charge after two consecutive touch_ins" do
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by -Oystercard::PENALTY_FARE
    end

    it "expects penalty charge after touch_out without touch_in" do
      expect{oystercard.touch_out(entry_station)}.to change{oystercard.balance}.by -Oystercard::PENALTY_FARE
    end

    it "expects a touch_out and touch_in to charge minimum fare" do
      entry_station = double("station", :zone => 1)
      exit_station = double("station", :zone => 4)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -3
    end

  end
end
