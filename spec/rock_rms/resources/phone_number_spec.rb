require 'spec_helper'

RSpec.describe RockRMS::Client::PhoneNumber, type: :model do
  include_context 'resource specs'

  describe '#create_phone_number' do
    context 'arguments' do
      subject { client.create_phone_number }

      it 'requires `number_type_value_id`' do
        expect { subject }.to raise_error(ArgumentError, /number_type_value_id/)
      end

      it 'requires `number`' do
        expect { subject }.to raise_error(ArgumentError, /number/)
      end

      it 'requires `person_id`' do
        expect { subject }.to raise_error(ArgumentError, /person_id/)
      end
    end

    subject(:resource) do
      client.create_phone_number(
        number_type_value_id: 13,
        number: '5555555555',
        person_id: 1
      )
    end

    it 'returns an integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'PhoneNumbers',
          {
            'IsSystem' => true,
            'IsMessagingEnabled' => false,
            'NumberTypeValueId' => 13,
            'Number' => '5555555555',
            'PersonId' => 1
          }
        ).and_call_original
      resource
    end
  end

  describe '#list_phone_numbers(options = {})' do
    subject(:resource) { client.list_phone_numbers }

    it 'returns a array of hashes' do
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end

    it 'queries phone numbers' do
      expect(client).to receive(:get).with('PhoneNumbers', {}).and_call_original
      resource
    end

    it 'passes options' do
      expect(client).to receive(:get)
        .with('PhoneNumbers', { option1: '1' })
        .and_return([])
      client.list_phone_numbers(option1: '1')
    end

    it 'formats with PhoneNumber' do
      response = double
      expect(RockRMS::Response::PhoneNumber).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      resource
    end
  end
end
