require 'spec_helper'

RSpec.describe RockRMS::Client::PaymentMethod, type: :model do
  include_context 'resource specs'

  describe '#list_payment_methods' do
    it 'returns a array' do
      resource = client.list_payment_methods
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#create_payment_method' do
    context 'arguments' do
      it 'require `payment_type`' do
        expect { client.create_payment_method }
          .to raise_error(ArgumentError, /payment_type/)
      end
    end

    subject(:resource) do
      client.create_payment_method(payment_type: 'card')
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'FinancialPaymentDetails',
          'CurrencyTypeValueId' => 156,
          'ForeignKey' => nil
        )
        .and_call_original
      resource
    end
  end

  describe '#delete_payment_method' do
    it 'returns nothing' do
      expect(client.delete_payment_method(123)).to eq(nil)
    end

    it 'passes id' do
      expect(client).to receive(:delete).with('FinancialPaymentDetails/123')
      client.delete_payment_method(123)
    end
  end
end
