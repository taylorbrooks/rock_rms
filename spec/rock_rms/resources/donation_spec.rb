require 'spec_helper'

RSpec.describe RockRMS::Client::Donation, type: :model do
  include_context 'resource specs'


  # find_donations_by_giving_id
  # update_donation

  describe '#list_donations' do
    it 'returns a array' do
      resource = client.list_donations
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_donation(id)' do
    it 'returns a hash' do
      expect(client.find_donation(123)).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('FinancialTransactions/123')
        .and_call_original

      resource = client.find_donation(123)

      expect(resource[:id]).to eq(1422)
    end

    it 'formats with Donation' do
      response = double
      expect(RockRMS::Responses::Donation).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_donation(123)
    end
  end



  describe '#create_donation' do
    context 'arguments' do
      it 'require `authorized_person_id`' do
        expect { client.create_donation }
          .to raise_error(ArgumentError, /authorized_person_id/)
      end

      it 'require `batch_id`' do
        expect { client.create_donation }
          .to raise_error(ArgumentError, /batch_id/)
      end

      it 'require `date`' do
        expect { client.create_donation }
          .to raise_error(ArgumentError, /date/)
      end

      it 'require `funds`' do
        expect { client.create_donation }
          .to raise_error(ArgumentError, /funds/)
      end

    end

    subject(:resource) {
      client.create_donation(
        authorized_person_id: 1,
        batch_id: 1,
        date: 1,
        funds: [{amount: 450,fund_id: 2}],
        payment_type: 1,
        transaction_code: "asdf",
        summary: "taco tuesday",
        recurring_donation_id: 1
      )
    }

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with('FinancialTransactions', {
           "AuthorizedPersonAliasId"=>1,
            "ScheduledTransactionId"=>1,
            "BatchId"=>1,
            "FinancialPaymentDetailId"=>1,
            "TransactionCode"=>"asdf",
            "TransactionDateTime"=>1,
            "TransactionDetails"=>[{"Amount"=>450, "AccountId"=>2}],
            "TransactionTypeValueId"=>53,
            "SourceTypeValueId"=>10,
            "Summary"=>"taco tuesday"
        })
        .and_call_original
      resource
    end
  end




  describe '#update_donation' do

    subject(:resource) {
      client.update_donation(123,
        batch_id: 1,
        summary: "taco tuesday"
      )
    }

    it 'returns nothing' do
      expect(client.update_donation(123)).to eq(nil)
    end

    it 'passes options' do
      expect(client).to receive(:patch)
        .with('FinancialTransactions/123', {
            "BatchId"=>1,
            "Summary"=>"taco tuesday"
        })
        .and_call_original
      resource
    end
  end



  describe '#delete_donation' do
    it 'returns nothing' do
      expect(client.delete_donation(123)).to eq(nil)
    end

    it 'passes id' do
      expect(client).to receive(:delete).with('FinancialTransactions/123')
      client.delete_donation(123)
    end
  end

end
