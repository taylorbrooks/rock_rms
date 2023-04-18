require 'spec_helper'

RSpec.describe RockRMS::Client::Group, type: :model do
  include_context 'resource specs'

  describe '#find_group(id)' do
    it 'returns a hash' do
      expect(client.find_group(123)).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('Groups/123').and_call_original

      resource = client.find_group(123)

      expect(resource[:id]).to eq(112_233)
    end

    it 'formats with Group' do
      response = double
      expect(RockRMS::Response::Group).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_group(123)
    end
  end

  describe '#list_groups(options = {})' do
    it 'returns a array of hashes' do
      resource = client.list_groups
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('Groups', {}).and_call_original
      client.list_groups
    end

    it 'passes options' do
      expect(client).to receive(:get)
        .with('Groups', { option1: '1' })
        .and_return([])
      client.list_groups(option1: '1')
    end

    it 'formats with Group' do
      response = double
      expect(RockRMS::Response::Group).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.list_groups
    end
  end

  describe '#list_groups_for_person' do
    it 'delegates to `list_groups`' do
      expect(client).to receive(:list_groups)
      client.list_groups_for_person(123)
    end

    it 'filters members by person_id' do
      expect(client).to receive(:list_groups).with(
        hash_including('$filter' => 'Members/any(m: m/PersonId eq 123)')
      )
      client.list_groups_for_person(123)
    end

    it 'expands member data by default' do
      expect(client).to receive(:list_groups).with(
        hash_including('$expand' => 'Members')
      )
      client.list_groups_for_person(123)
    end

    it 'supports passing additional filters' do
      expect(client).to receive(:list_groups).with(
        hash_including('$filter' => /GroupTypeId eq 45 and /)
      )
      client.list_groups_for_person(123, '$filter' => 'GroupTypeId eq 45')
    end
  end

  describe '#list_families_for_person' do
    it 'returns a array of hashes' do
      resource = client.list_families_for_person(123)
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end

    it 'queries families scoped to person' do
      expect(client).to receive(:get)
        .with('Groups/GetFamilies/123', {})
        .and_call_original
      client.list_families_for_person(123)
    end

    it 'passes options' do
      expect(client).to receive(:get)
        .with('Groups/GetFamilies/123', { option1: '1' })
        .and_return([])
      client.list_families_for_person(123, option1: '1')
    end

    it 'formats with Group' do
      response = double
      allow(client).to receive(:get).and_return(response)
      expect(RockRMS::Response::Group).to receive(:format).with(response)
      client.list_families_for_person(123)
    end
  end


  describe '#save_address' do
    context 'arguments' do
      it 'require `group_id`' do
        expect { client.save_group_address }
          .to raise_error(ArgumentError, /group_id/)
      end

      it 'require `location_type_id`' do
        expect { client.save_group_address }
          .to raise_error(ArgumentError, /location_type_id/)
      end

      it 'require `address`' do
        expect { client.save_group_address }
          .to raise_error(ArgumentError, /address/)
      end

    end

    subject(:resource) do
      client.save_group_address(group_id: 1, location_type_id: 1, address: { street1: '123 Main St', postal_code: '12345' })
    end

    it 'passes options' do
      expect(client).to receive(:put)
        .with(
          "Groups/SaveAddress/1/1",
          {
            'street1' => '123 Main St',
            'postalCode' => '12345'
          }
        ).and_call_original
      resource
    end
  end
end
