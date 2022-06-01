require 'spec_helper'

RSpec.describe RockRMS::Client::Transaction, type: :model do
  include_context 'resource specs'

  describe '#list_transactions' do
    it 'returns a array' do
      resource = client.list_transactions
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_transaction(id)' do
    it 'returns a hash' do
      expect(client.find_transaction(123)).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('FinancialTransactions/123')
        .and_call_original

      resource = client.find_transaction(123)

      expect(resource[:id]).to eq(1422)
    end

    it 'formats with Transaction' do
      response = double
      expect(RockRMS::Response::Transaction).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_transaction(123)
    end
  end

  describe '#create_transaction' do
    context 'arguments' do
      it 'require `authorized_person_id`' do
        expect { client.create_transaction }
          .to raise_error(ArgumentError, /authorized_person_id/)
      end

      it 'require `batch_id`' do
        expect { client.create_transaction }
          .to raise_error(ArgumentError, /batch_id/)
      end

      it 'require `date`' do
        expect { client.create_transaction }
          .to raise_error(ArgumentError, /date/)
      end

      it 'require `funds`' do
        expect { client.create_transaction }
          .to raise_error(ArgumentError, /funds/)
      end

    end

    subject(:resource) do
      client.create_transaction(
        authorized_person_id: 1,
        batch_id: 1,
        date: 1,
        funds: [{ amount: 450, fund_id: 2 }],
        payment_detail_id: 1,
        transaction_code: 'asdf',
        summary: 'taco tuesday',
        recurring_donation_id: 1
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'FinancialTransactions',
          'AuthorizedPersonAliasId' => 1,
          'ScheduledTransactionId' => 1,
          'BatchId' => 1,
          'FinancialGatewayId' => nil,
          'FinancialPaymentDetailId' => 1,
          'TransactionCode' => 'asdf',
          'TransactionDateTime' => 1,
          'TransactionDetails' => [{ 'Amount' => 450, 'AccountId' => 2, 'EntityTypeId' => nil, 'EntityId' => nil, 'FeeAmount' => nil }],
          'TransactionTypeValueId' => 53,
          'SourceTypeValueId' => 10,
          'Summary' => 'taco tuesday'
        )
        .and_call_original
      resource
    end
  end

  describe '#update_transaction' do
    subject(:resource) do
      client.update_transaction(
        123,
        batch_id: 1,
        summary: 'taco tuesday',
        source_type_id: 5,
        transaction_type_value_id: 54
      )
    end

    it 'returns nothing' do
      expect(client.update_transaction(123)).to eq(nil)
    end

    it 'passes options' do
      expect(client).to receive(:patch)
        .with(
          'FinancialTransactions/123',
          'BatchId' => 1,
          'Summary' => 'taco tuesday',
          'TransactionTypeValueId' => 54,
          'SourceTypeValueId' => 5
        )
        .and_call_original
      resource
    end
  end

  describe '#delete_transaction' do
    it 'returns nothing' do
      expect(client.delete_transaction(123)).to eq(nil)
    end

    it 'passes id' do
      expect(client).to receive(:delete).with('FinancialTransactions/123')
      client.delete_transaction(123)
    end
  end
end
