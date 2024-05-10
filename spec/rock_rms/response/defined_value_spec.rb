require 'spec_helper'

RSpec.describe RockRMS::Response::DefinedValue, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('defined_values.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'has the correct number keys' do
      keys = result.first.keys
      expect(keys.count).to eq(11)
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:value]).to eq(p['Value'])
        expect(r[:guid]).to eq(p['Guid'])
        expect(r[:description]).to eq(p['Description'])
      end
    end
  end
end
