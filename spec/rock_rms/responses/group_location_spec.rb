require 'spec_helper'

RSpec.describe RockRMS::Responses::GroupLocation, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('group_locations.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:group_id]).to eq(p['GroupId'])
        expect(r[:location_id]).to eq(p['LocationId'])
        expect(r[:guid]).to eq(p['Guid'])
      end
    end

    context 'when locations are included' do
      it 'formats with GroupLocations' do
        location = double
        parsed.first['Location'] = location
        expect(RockRMS::Responses::Location).to receive(:format)
          .with(location)
          .and_return({ some_key: :value })
        result
        expect(result.first[:location]).to eq({ some_key: :value })
      end
    end
  end
end
