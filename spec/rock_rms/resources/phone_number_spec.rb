require 'spec_helper'

RSpec.describe RockRMS::Client::PhoneNumber, type: :model do
  include_context 'resource specs'

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
        .with('PhoneNumbers', option1: '1')
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
