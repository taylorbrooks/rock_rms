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
            {
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
                'SourceTypeValueId' => 10,
                'ScheduledTransactionId' => 1,
                'TransactionCode' => nil
              }
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
            {
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
                'ScheduledTransactionId' => 1,
                'TransactionTypeValueId' => 53,
                'SourceTypeValueId' => 10,
                'TransactionCode' => nil
              }
            }
          )
          .and_call_original
        resource
      end
    end
  end

  describe 'apportioning a partial refund' do
    def details_for(*amounts)
      amounts.each_with_index.map do |amount, index|
        { amount: amount, fund_id: index + 1, entity_type_id: nil, entity_id: nil }
      end
    end

    def refunded_amounts(details, refund_amount)
      client.send(:refunded_details, details, refund_amount).map { |line| line['Amount'] }
    end

    it 'gives the leftover cent to the largest remainder, ties to the earlier line' do
      lines = client.send(:refunded_details, details_for(250, 20, 50), 100)

      expect(lines.map { |line| line['Amount'] }).to eq([-78.13, -6.25, -15.62])
      expect(lines.map { |line| line['AccountId'] }).to eq([1, 2, 3])
    end

    it 'sums to exactly the refund for every partial refund in whole cents' do
      details = details_for(123.45, 67.89, 0.67, 19.99)

      misses = (1..21_199).reject do |refund_cents|
        line_cents = refunded_amounts(details, refund_cents / 100.0).sum { |amount| (amount * 100).round }
        line_cents == -refund_cents
      end

      expect(misses).to be_empty
    end

    it 'keeps a $0.00 line' do
      expect(refunded_amounts(details_for(50, 0, 50), 33.33)).to eq([-16.67, 0, -16.66])
    end

    it 'refunds a negative line as a positive amount' do
      expect(refunded_amounts(details_for(101, -21), 40)).to eq([-50.5, 10.5])
    end

    it 'negates each original amount on a full refund' do
      details = details_for(10, 90.5)

      expect(refunded_amounts(details, 100.5)).to eq([-10, -90.5])
      expect(refunded_amounts(details, 150)).to eq([-10, -90.5])
    end

    it 'leaves the passed-in details unchanged' do
      details = details_for(250, 20, 50)

      client.send(:refunded_details, details, 100)

      expect(details.map { |detail| detail[:amount] }).to eq([250, 20, 50])
    end
  end
end
