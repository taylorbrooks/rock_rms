require 'spec_helper'

RSpec.describe RockRMS::Response::TransactionDetail, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('transaction_details.json')) }

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
        expect(r[:fund_id]).to eq(p['AccountId'])
        expect(r[:amount]).to eq(p['Amount'])
      end
    end
  end
end
