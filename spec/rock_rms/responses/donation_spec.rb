require 'spec_helper'

RSpec.describe RockRMS::Responses::Donation, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('donations.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'translates keys' do
      puts parsed
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:date]).to eq(p['TransactionDateTime'])
        expect(r[:batch_id]).to eq(p['BatchId'])
        expect(r[:scheduled_transaction_id]).to eq(p['ScheduledTransactionId'])
        expect(r[:summary]).to eq(p['Summary'])
      end
    end
  end
end
