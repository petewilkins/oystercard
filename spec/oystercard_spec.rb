require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#initialze' do
    it 'has an initial balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it {is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds top-up value to the balance' do
      expect{ oystercard.top_up 20}.to change{ oystercard.balance }.by 20
    end
  end

end
