require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#initialze' do
    it 'has balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'adds to balance' do
      expect{ oystercard.top_up 20}.to change{ oystercard.balance }.by 20
    end

    it 'raises error if limit exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{ oystercard.top_up 1 }.to raise_error "Top up unsuccessful: Balance cannot exceed £#{maximum_balance}."
    end
  end

  describe '#deduct' do
    it "fare from balance" do
      oystercard.top_up 20
      expect{ oystercard.deduct 5 }.to change{ oystercard.balance}.by -5
    end
  end

  describe '#not in_journey' do
    it 'initially' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes in_journey? to true' do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'changes in_journey? to false' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end
end
