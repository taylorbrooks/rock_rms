require 'spec_helper'

RSpec.describe RockRMS::Client::RecurringDonationDetail, type: :model do
  include_context 'resource specs'

  describe '#update_recurring_donation_detail' do
    subject(:resource) do
      client.update_recurring_donation_detail(
        123,
        fund_id: 2,
        amount: 100.0
      )
    end

    it 'returns nothing' do
      expect(client.update_recurring_donation_detail(123, fund_id: 5, amount: 100.0)).to eq(nil)
    end

    it 'passes options' do
      expect(client).to receive(:patch)
        .with(
          'FinancialScheduledTransactionDetails/123',
          'AccountId' => 2,
          'Amount' => 100.0
        ).and_call_original
      resource
    end
  end
end
