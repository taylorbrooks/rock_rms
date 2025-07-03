require 'spec_helper'

RSpec.describe RockRMS::Response::ContentChannelType, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('content_channel_types.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'has the correct number keys' do
      keys = result.first.keys
      expect(keys.count).to eq(10)
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:name]).to eq(p['Name'])
      end
    end
  end
end
