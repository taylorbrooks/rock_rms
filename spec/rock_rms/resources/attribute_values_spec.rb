require 'spec_helper'

RSpec.describe RockRMS::Client::AttributeValue, type: :model do
  include_context 'resource specs'

  describe '#list_attribute_values' do
    it 'returns a array' do
      resource = client.list_attribute_values
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#create_attribute_value' do
    context 'arguments' do
      it 'require `attribute_id`' do
        expect { client.create_attribute_value }
          .to raise_error(ArgumentError, /attribute_id/)
      end

      it 'require `entity_id`' do
        expect { client.create_attribute_value }
          .to raise_error(ArgumentError, /entity_id/)
      end

      it 'require `value`' do
        expect { client.create_attribute_value }
          .to raise_error(ArgumentError, /value/)
      end
    end

    subject(:resource) do
      client.create_attribute_value(
        attribute_id: 12993,
        entity_id: 731,
        value: 100
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'AttributeValues',
          'AttributeId' => 12993,
          'EntityId'    => 731,
          'Value'       => 100,
          'IsSystem'    => false
        )
        .and_call_original
      resource
    end
  end
end
