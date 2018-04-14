require 'spec_helper'

RSpec.describe RockRMS::Response::Attribute, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('attributes.json')) }

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
        expect(r[:key]).to eq(p['Key'])
        expect(r[:description]).to eq(p['Description'])
      end
    end
  end
end
