require 'spec_helper'

RSpec.describe RockRMS::Client::Person, type: :model do
  include_context 'resource specs'

  describe '#find_person_by_name(full_name)' do
    it 'returns a array of hashes' do
      resource = client.find_person_by_name('Some Name')
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end

    it 'queries people by name' do
      expect(client).to receive(:get)
        .with('People/Search', hash_including(name: 'Some Name'))
        .and_call_original
      client.find_person_by_name('Some Name')
    end

    it 'includes default options' do
      expect(client).to receive(:get)
        .with(
          'People/Search',
          hash_including(**described_class::NAME_SEARCH_DEFAULTS)
        ).and_call_original
      client.find_person_by_name('Some Name')
    end

    it 'passes options' do
      expect(client).to receive(:get)
        .with('People/Search', hash_including(option1: '1'))
        .and_call_original
      client.find_person_by_name('Some Name', option1: '1')
    end

    it 'overrides default options' do
      expect(client).to receive(:get)
        .with('People/Search', hash_including(includeHtml: true))
        .and_call_original
      client.find_person_by_name('Some Name', includeHtml: true)
    end

    it 'formats with Person' do
      response = double
      expect(RockRMS::Responses::Person).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_person_by_name('Some Name')
    end
  end
end
