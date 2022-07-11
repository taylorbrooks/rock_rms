require 'spec_helper'

RSpec.describe RockRMS::Client::SavedPaymentMethod, type: :model do
  include_context 'resource specs'

  describe '#list_saved_payment_methods' do
    it 'returns a array' do
      resource = client.list_saved_payment_methods
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#create_saved_payment_method' do
    context 'arguments' do
      it 'require `gateway_id`' do
        expect { client.create_saved_payment_method }
          .to raise_error(ArgumentError, /gateway_id/)
      end

      it 'require `payment_detail_id`' do
        expect { client.create_saved_payment_method }
          .to raise_error(ArgumentError, /payment_detail_id/)
      end

      it 'require `person_alias_id`' do
        expect { client.create_saved_payment_method }
          .to raise_error(ArgumentError, /person_alias_id/)
      end

      it 'require `name`' do
        expect { client.create_saved_payment_method }
          .to raise_error(ArgumentError, /name/)
      end

      it 'require `reference_number`' do
        expect { client.create_saved_payment_method }
          .to raise_error(ArgumentError, /reference_number/)
      end
    end

    subject(:resource) do
      client.create_saved_payment_method(
        gateway_id: 2,
        payment_detail_id: 1,
        person_alias_id: 1,
        name: 'Sapphire Preferred',
        reference_number: 'card_1234'
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'FinancialPersonSavedAccounts',
          'Name' => 'Sapphire Preferred',
          'ReferenceNumber' => 'card_1234',
          'PersonAliasId' => 1,
          'IsDefault' => 0,
          'FinancialGatewayId' => 2,
          'FinancialPaymentDetailId' => 1
        ).and_call_original
      resource
    end
  end

  describe '#delete_saved_payment_method' do
    it 'returns nothing' do
      expect(client.delete_saved_payment_method(123)).to eq(nil)
    end

    it 'passes id' do
      expect(client).to receive(:delete).with('FinancialPersonSavedAccounts/123')
      client.delete_saved_payment_method(123)
    end
  end
end
