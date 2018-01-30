require 'spec_helper'

RSpec.describe RockRMS::Response::Location, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('locations.json')) }

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
        expect(r[:name]).to eq(p['Name'])
        expect(r[:is_active]).to eq(p['IsActive'])
        expect(r[:street1]).to eq(p['Street1'])
        expect(r[:street2]).to eq(p['Street2'])
        expect(r[:city]).to eq(p['City'])
        expect(r[:county]).to eq(p['County'])
        expect(r[:state]).to eq(p['State'])
        expect(r[:country]).to eq(p['Country'])
        expect(r[:postal_code]).to eq(p['PostalCode'])
        expect(r[:latitude]).to eq(p['Latitude'])
        expect(r[:longitude]).to eq(p['Longitude'])
        expect(r[:guid]).to eq(p['Guid'])
      end
    end
  end
end
