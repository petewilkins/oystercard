require 'station'

describe Station do

  subject(:station) {described_class.new("Old St.",1)}

  describe "#initalize" do

    it 'has a name on creation' do
      expect(station.name).to eq "Old St."
    end

    it 'has a zone on creation' do
      expect(station.zone).to eq 1
    end
  end

end
