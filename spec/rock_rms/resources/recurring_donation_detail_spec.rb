require 'spec_helper'

RSpec.describe RockRMS::Client::RecurringDonationDetail, type: :model do
  include_context 'resource specs'

  describe '#create_recurring_donation_detail' do
    context 'arguments' do
      it 'require `fund_id`' do
        expect { client.create_recurring_donation_detail }
          .to raise_error(ArgumentError, /fund_id/)
      end

      it 'require `amount`' do
        expect { client.create_recurring_donation_detail }
          .to raise_error(ArgumentError, /amount/)
      end

      it 'require `recurring_donation_id`' do
        expect { client.create_recurring_donation_detail }
          .to raise_error(ArgumentError, /recurring_donation_id/)
      end

    end

    subject(:resource) do
      client.create_recurring_donation_detail(
        fund_id: 1,
        amount: 5.00,
        recurring_donation_id: 1
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'FinancialScheduledTransactionDetails',
          {
            'AccountId' => 1,
            'ScheduledTransactionId' => 1,
            'Amount' => 5.00,
          }
        )
        .and_call_original
      resource
    end
  end

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
          {
            'AccountId' => 2,
            'Amount' => 100.0
          }
        ).and_call_original
      resource
    end
  end

  describe '#delete_recurring_donation_detail' do
    subject(:resource) do
      client.delete_recurring_donation_detail(123)
    end

    it 'returns nothing' do
      expect(client.delete_recurring_donation_detail(123)).to eq(nil)
    end

    it 'passes options' do
      expect(client).to receive(:delete).with('FinancialScheduledTransactionDetails/123').and_call_original
      resource
    end
  end
end
