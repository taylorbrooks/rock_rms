require 'spec_helper'

RSpec.describe RockRMS::Response::Batch, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('batches.json')) }

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
        expect(r[:control_amount]).to eq(p['ControlAmount'])
        expect(r[:transactions]).to eq(
          RockRMS::Response::Transaction.format(p['Transactions'])
        )
        expect(r[:amount]).to eq(0)
      end
    end
  end
end
