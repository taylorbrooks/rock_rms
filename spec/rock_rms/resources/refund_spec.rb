require 'spec_helper'

RSpec.describe RockRMS::Client::Refund, type: :model do
  include_context 'resource specs'

  describe '#create_refund' do
    context 'arguments' do
      it 'require `authorized_person_id`' do
        expect { client.create_refund }
          .to raise_error(ArgumentError, /transaction_id/)
      end

      it 'require `batch_id`' do
        expect { client.create_refund }
          .to raise_error(ArgumentError, /batch_id/)
      end

      it 'require `date`' do
        expect { client.create_refund }
          .to raise_error(ArgumentError, /date/)
      end

      it 'require `funds`' do
        expect { client.create_refund }
          .to raise_error(ArgumentError, /reason_id/)
      end

    end

    subject(:resource) do
      client.create_refund(
        transaction_id: 1422,
        batch_id: 1,
        date: '2018-02-01',
        reason_id: 1
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'FinancialTransactionRefunds',
          'OriginalTransactionId' => 1422,
          'RefundReasonValueId' => 1,
          'FinancialTransaction' => {
            'AuthorizedPersonAliasId' => 120,
            'BatchId' => 1,
            'FinancialPaymentDetailId' => 156,
            'TransactionDateTime' => '2018-02-01',
            'TransactionDetails'  => [
              {
                'Amount' => -100.0,
                'AccountId' => 23
              }
            ],
            'TransactionTypeValueId' => 53
          }
        )
        .and_call_original
      resource
    end
  end
end
