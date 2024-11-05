require 'spec_helper'

RSpec.describe RockRMS::Response::ContentChannelItem, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('content_channel_items.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'has the correct number keys' do
      keys = result.first.keys
      expect(keys.count).to eq(14)
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:foreign_key]).to eq(p['ForeignKey'])
        expect(r[:content_channel_id]).to eq(p['ContentChannelId'])
        expect(r[:title]).to eq(p['Title'])
        expect(r[:content]).to eq(p['Content'])
        expect(r[:order]).to eq(p['Order'])
        expect(r[:start_date]).to eq(p['StartDateTime'])
        expect(r[:expire_date]).to eq(p['ExpireDateTime'])
      end
    end
  end
end
