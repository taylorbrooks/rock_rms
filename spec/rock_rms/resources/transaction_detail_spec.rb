require 'spec_helper'

RSpec.describe RockRMS::Client::TransactionDetail, type: :model do
  include_context 'resource specs'

  describe '#list_transaction_details' do
    it 'returns a array' do
      resource = client.list_transaction_details
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_transaction_detail(id)' do
    it 'returns a hash' do
      expect(client.find_transaction_detail(123)).to be_a(Hash)
    end

    it 'queries ' do
      expect(client).to receive(:get).with('FinancialTransactionDetails/123')
        .and_call_original

      resource = client.find_transaction_detail(123)

      expect(resource[:id]).to eq(345)
    end

    it 'formats with TransactionDetail' do
      response = double
      expect(RockRMS::Response::TransactionDetail).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_transaction_detail(123)
    end
  end

  describe '#update_transaction_detail' do
    context 'simple' do
      subject(:resource) do
        client.update_transaction_detail(
          123,
          fund_id: 2,
        )
      end

      it 'returns nothing' do
        expect(client.update_transaction_detail(123, fund_id: 5)).to eq(nil)
      end

      it 'passes options' do
        expect(client).to receive(:patch)
          .with(
            'FinancialTransactionDetails/123',
            {
              'AccountId' => 2
            }
          ).and_call_original
        resource
      end
    end

    context 'complex' do
      subject(:resource) do
        client.update_transaction_detail(
          123,
          fund_id: 2,
          fee_amount: 50,
          fee_coverage_amount: 45
        )
      end

      it 'passes options' do
        expect(client).to receive(:patch)
          .with(
            'FinancialTransactionDetails/123',
            {
              'FeeAmount' => 50,
              'FeeCoverageAmount' => 45,
              'AccountId' => 2
            }
          ).and_call_original
        resource
      end
    end

    describe '#create_transaction_detail' do
      context 'simple' do
        subject(:resource) do
          client.create_transaction_detail(
            transaction_id: 123,
            fund_id: 2,
            amount: 5.00
          )
        end
  
        it 'returns nothing' do
          expect(subject).to eq(12345)
        end
  
        it 'passes options' do
          expect(client).to receive(:post)
            .with(
              'FinancialTransactionDetails',
              {
                'AccountId' => 2,
                'Amount' => 5.00,
                'TransactionId' => 123
              }
            ).and_call_original
          resource
        end
      end
    end

    describe '#delete_transaction_detail' do
      it 'returns nothing' do
        expect(client.delete_transaction_detail(123)).to eq(nil)
      end

      it 'passes id' do
        expect(client).to receive(:delete).with('FinancialTransactionDetails/123')
        client.delete_transaction_detail(123)
      end
    end

  end
end
