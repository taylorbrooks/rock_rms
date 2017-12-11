require 'spec_helper'

RSpec.describe RockRMS::Responses::Group, type: :model do
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
        expect(r[:is_active]).to eq(p['IsActive'])
        expect(r[:group_type_id]).to eq(p['GroupTypeId'])
        expect(r[:parent_group_id]).to eq(p['ParentGroupId'])
        expect(r[:campus_id]).to eq(p['CampusId'])
        expect(r[:guid]).to eq(p['Guid'])
        expect(r[:campus_id]).to eq(p['CampusId'])
        expect(r[:members]).to eq(p['Members'])
      end
    end
  end
end
