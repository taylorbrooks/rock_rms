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

    context "without amount param" do

      subject(:resource) do
        client.create_refund(
          transaction_id: 3000,
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
            'OriginalTransactionId' => 3000,
            'RefundReasonValueId' => 1,
            'FinancialTransaction' => {
              'AuthorizedPersonAliasId' => 120,
              'BatchId' => 1,
              'FinancialGatewayId' => nil,
              'FinancialPaymentDetailId' => 156,
              'TransactionDateTime' => '2018-02-01',
              'TransactionDetails'  => [
                {
                  "Amount"=>-10.0,
                  "AccountId"=>23,
                  "EntityTypeId" => nil,
                  "EntityId" => nil
                },
                {
                  "Amount"=> -90.0,
                  "AccountId"=>24,
                  "EntityTypeId" => nil,
                  "EntityId" => nil
                }
              ],
              'TransactionTypeValueId' => 53,
              'TransactionCode' => nil
            }
          )
          .and_call_original
        resource
      end

    end

    context "with amount param" do

      subject(:resource) do
        client.create_refund(
          transaction_id: 3000,
          batch_id: 1,
          date: '2018-02-01',
          reason_id: 1,
          amount: 75.55,
        )
      end

      it 'returns integer' do
        expect(resource).to be_a(Integer)
      end

      it 'passes options' do
        expect(client).to receive(:post)
          .with(
            'FinancialTransactionRefunds',
            'OriginalTransactionId' => 3000,
            'RefundReasonValueId' => 1,
            'FinancialTransaction' => {
              'AuthorizedPersonAliasId' => 120,
              'BatchId' => 1,
              'FinancialGatewayId' => nil,
              'FinancialPaymentDetailId' => 156,
              'TransactionDateTime' => '2018-02-01',
              'TransactionDetails'  => [
                {
                  "Amount"=>-7.56,
                  "AccountId"=>23,
                  "EntityTypeId" => nil,
                  "EntityId" => nil
                },
                {
                  "Amount"=>-67.99,
                  "AccountId"=>24,
                  "EntityTypeId" => nil,
                  "EntityId" => nil
                }
              ],
              'TransactionTypeValueId' => 53,
              'TransactionCode' => nil
            }
          )
          .and_call_original
        resource
      end
    end
  end
end
