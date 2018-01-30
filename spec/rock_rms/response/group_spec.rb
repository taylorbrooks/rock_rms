require 'spec_helper'

RSpec.describe RockRMS::Response::Group, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('groups_with_members.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:name]).to eq(p['Name'])
        expect(r[:group_type_id]).to eq(p['GroupTypeId'])
        expect(r[:parent_group_id]).to eq(p['ParentGroupId'])
        expect(r[:campus_id]).to eq(p['CampusId'])
        expect(r[:is_active]).to eq(p['IsActive'])
        expect(r[:guid]).to eq(p['Guid'])
        expect(r[:members]).to eq(p['Members'])
      end
    end

    context 'when locations are included' do
      let(:parsed) { JSON.parse(FixturesHelper.read('groups_with_locations.json')) }

      it 'formats with GroupLocations' do
        expect(RockRMS::Response::GroupLocation).to receive(:format)
          .with(parsed.first['GroupLocations'])
          .and_return([{ some_key: :value }])
        result
        expect(result.first[:group_locations]).to eq([{ some_key: :value }])
      end
    end

    context 'when campus is included' do
      let(:parsed) { JSON.parse(FixturesHelper.read('groups_with_campus.json')) }

      it 'formats with Campus' do
        expect(RockRMS::Response::Campus).to receive(:format)
          .with(parsed.first['Campus'])
          .and_return([{ some_key: :value }])
        result
        expect(result.first[:campus]).to eq([{ some_key: :value }])
      end
    end
  end
end
