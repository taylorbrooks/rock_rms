require 'spec_helper'

RSpec.describe RockRMS::Response::AttributeValue, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('attribute_values.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'has the correct number keys' do
      keys = result.first.keys
      expect(keys.count).to eq(9)
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:value]).to eq(p['Value'])
        expect(r[:value_as_number]).to eq(p['ValueAsNumeric'])
        expect(r[:entity_id]).to eq(p['EntityId'])
      end
    end
  end
end
