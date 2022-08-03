require 'spec_helper'

RSpec.describe RockRMS::Client::RefundReason, type: :model do
  include_context 'resource specs'

  describe '#list_refund_reasons' do
    it 'returns a array' do
      resource = client.list_refund_reasons
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#create_refund_reason' do
    context 'arguments' do

      it 'require `value`' do
        expect { client.create_refund_reason }
          .to raise_error(ArgumentError, /value/)
      end

      it 'require `description`' do
        expect { client.create_refund_reason }
          .to raise_error(ArgumentError, /description/)
      end

    end

    subject(:resource) do
      client.create_refund_reason(
        value: "Angry Donor",
        description: "Very Very not Happy",
        order: 500,
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'DefinedValues',
          {
            'DefinedTypeId' => 37,
            'IsSystem' => false,
            'Order' => 500,
            'Description' => "Very Very not Happy",
            'Value' => "Angry Donor",
            'IsActive' => false
          }
        )
        .and_call_original
      resource
    end
  end
end
