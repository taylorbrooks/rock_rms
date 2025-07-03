require 'spec_helper'

RSpec.describe RockRMS::Response::ContentChannel, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('content_channels.json')) }

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
        expect(r[:name]).to eq(p['Name'])
        expect(r[:description]).to eq(p['Description'])
        expect(r[:is_active]).to eq(p['IsActive'])
        expect(r[:icon_css_class]).to eq(p['IconCssClass'])
        expect(r[:content_channel_type_id]).to eq(p['ContentChannelTypeId'])
      end
    end
  end
end
