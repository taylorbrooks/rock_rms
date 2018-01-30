require 'spec_helper'

RSpec.describe RockRMS::Response::RecurringDonation, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('recurring_donations.json')) }

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
        expect(r[:foreign_key]).to eq(p['ForeignKey'])
        expect(r[:next_payment_date]).to eq(p['NextPaymentDate'])
        expect(r[:person_id]).to eq(p['AuthorizedPersonAliasId'])
        expect(r[:transaction_details]).to eq(
          RockRMS::Response::RecurringDonationDetails.format(p['ScheduledTransactionDetails'])
        )
        expect(r[:transaction_code]).to eq(p['TransactionCode'])
      end
    end
  end
end
