require 'spec_helper'

RSpec.describe RockRMS::Client::RecurringDonation, type: :model do
  include_context 'resource specs'

  describe '#list_recurring_donations(options = {})' do
    it 'returns a array of hashes' do
      resource = client.list_recurring_donations
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end

    it 'queries recurring donations' do
      expect(client).to receive(:get)
        .with('FinancialScheduledTransactions', {})
        .and_call_original
      client.list_recurring_donations
    end

    it 'formats with RecurringDonation' do
      response = double
      expect(RockRMS::Response::RecurringDonation).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.list_recurring_donations
    end
  end

  describe '#find_recurring_donation(id)' do
    it 'returns a hash' do
      expect(client.find_recurring_donation(12_345)).to be_a(Hash)
    end

    it 'queries recurring donations' do
      expect(client).to receive(:get)
        .with('FinancialScheduledTransactions/12345')
        .and_call_original

      resource = client.find_recurring_donation(12_345)

      expect(resource[:id]).to eq(12_345)
    end

    it 'formats with RecurringDonation' do
      response = double
      expect(RockRMS::Response::RecurringDonation).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_recurring_donation(12_345)
    end
  end

  describe '#update_recurring_donation(id)' do
    it 'updates the recurring donation' do
      expect(client).to receive(:patch)
        .with(
          'FinancialScheduledTransactions/123',
          {
            'NextPaymentDate' => '2018-01-01'
          }
      ).and_call_original

      resource = client.update_recurring_donation(
        123,
        next_payment_date: '2018-01-01'
      )

      expect(resource).to be_nil
    end

    it 'updates status_message with nil' do
      expect(client).to receive(:patch)
        .with(
          'FinancialScheduledTransactions/123',
          {
            'NextPaymentDate' => '2018-01-01',
            'StatusMessage' => ''
          }
      ).and_call_original

      resource = client.update_recurring_donation(
        123,
        next_payment_date: '2018-01-01',
        status_message: ''
      )

      expect(resource).to be_nil
    end

    context 'arguments' do
      it 'require `id`' do
        expect { client.update_recurring_donation }
          .to raise_error(ArgumentError, /wrong number/)
      end
    end

    subject(:resource) do
      client.update_recurring_donation(
        1,
        transaction_code: 'recur_1234',
        next_payment_date: '2018-01-01'
      )
    end

    it 'returns nil' do
      expect(resource).to be_nil
    end
  end

  describe '#create_recurring_donation' do
    context 'arguments' do
      it 'require `authorized_person_id`' do
        expect { client.create_recurring_donation }
          .to raise_error(ArgumentError, /authorized_person_id/)
      end

      it 'require `frequency`' do
        expect { client.create_recurring_donation }
          .to raise_error(ArgumentError, /frequency/)
      end

      it 'require `next_payment_date`' do
        expect { client.create_recurring_donation }
          .to raise_error(ArgumentError, /next_payment_date/)
      end

      it 'require `start_date`' do
        expect { client.create_recurring_donation }
          .to raise_error(ArgumentError, /start_date/)
      end

      it 'require `funds`' do
        expect { client.create_recurring_donation }
          .to raise_error(ArgumentError, /funds/)
      end
    end

    subject(:resource) do
      client.create_recurring_donation(
        authorized_person_id: 1,
        funds: [{ amount: 450, fund_id: 2 }],
        transaction_code: 'asdf',
        frequency: 'monthly',
        next_payment_date: '2010-01-01',
        start_date: '2010-01-01'
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'FinancialScheduledTransactions',
          {
            'AuthorizedPersonAliasId' => 1,
            'TransactionFrequencyValueId' => 135,
            'StartDate' => '2010-01-01',
            'NextPaymentDate' => '2010-01-01',
            'IsActive' => true,
            'FinancialGatewayId' => nil,
            'FinancialPaymentDetailId' => nil,
            'TransactionCode' => 'asdf',
            'ScheduledTransactionDetails' => [{ 'Amount' => 450, 'AccountId' => 2, 'EntityId' => nil, 'EntityTypeId' => nil, 'FeeAmount' => nil, 'FeeCoverageAmount' => nil, 'Summary' => nil}],
            'GatewayScheduleId' => nil,
            'SourceTypeValueId' => 10,
            'ForeignKey' => nil,
            'Summary' => nil,
            'Status' => nil,
            'StatusMessage' => nil
          }
        )
        .and_call_original
      resource
    end
  end
end
