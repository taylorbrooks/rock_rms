require 'spec_helper'

RSpec.describe RockRMS::Client::Attribute, type: :model do
  include_context 'resource specs'

  describe '#list_attributes' do
    it 'returns a array' do
      resource = client.list_attributes
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#create_attribute' do
    context 'arguments' do
      it 'require `field_type_id`' do
        expect { client.create_attribute }
          .to raise_error(ArgumentError, /field_type_id/)
      end

      it 'require `entity_type_id`' do
        expect { client.create_attribute }
          .to raise_error(ArgumentError, /entity_type_id/)
      end

      it 'require `key`' do
        expect { client.create_attribute }
          .to raise_error(ArgumentError, /key/)
      end

      it 'require `name`' do
        expect { client.create_attribute }
          .to raise_error(ArgumentError, /name/)
      end
    end

    subject(:resource) do
      client.create_attribute(
        key: 'TransactionFee',
        name: 'Transaction Fee',
        entity_type_id: 85,
        field_type_id: 14,
        description: 'Transaction fees for a specific gateway',
        order: 1234
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'Attributes',
          'FieldTypeId' => 14,
          'EntityTypeId' => 85,
          'Key' => 'TransactionFee',
          'Name' => 'Transaction Fee',
          'Description' => 'Transaction fees for a specific gateway',
          'Order' => 1234,
          'IsSystem'     => false,
          'IsGridColumn' => false,
          'IsMultiValue' => false,
          'IsRequired'   => false,
          'AllowSearch'  => false
        )
        .and_call_original
      resource
    end
  end
end
