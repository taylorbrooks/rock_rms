require 'spec_helper'

RSpec.describe RockRMS::Response::Transaction, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('transactions.json')) }

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
        expect(r[:date]).to eq(p['TransactionDateTime'])
        expect(r[:batch_id]).to eq(p['BatchId'])
        expect(r[:recurring_donation_id]).to eq(p['ScheduledTransactionId'])
        expect(r[:summary]).to eq(p['Summary'])
        expect(r[:transaction_code]).to eq(p['TransactionCode'])
        expect(r[:details]).to eq(
          RockRMS::Response::TransactionDetail.format(p['TransactionDetails'])
        )
        expect(r[:amount]).to eq(100.00)
      end
    end
  end
end
