require 'spec_helper'

RSpec.describe RockRMS::Client::GroupMember, type: :model do
  include_context 'resource specs'

  describe '#list_group_members' do
    it 'returns a array' do
      resource = client.list_group_members

      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
      expect(resource.first).to include(:group_id)
      expect(resource.first[:person]).to include(:id)
      expect(resource.first[:person]).to include(:email)
    end
  end

  describe '#create_group_member' do
    context 'arguments' do
      it 'require `group_id`' do
        expect { client.create_group_member }
          .to raise_error(ArgumentError, /group_id/)
      end

      it 'require `group_member_status`' do
        expect { client.create_group_member }
          .to raise_error(ArgumentError, /group_member_status/)
      end

      it 'require `group_role_id`' do
        expect { client.create_group_member }
          .to raise_error(ArgumentError, /group_role_id/)
      end

      it 'require `person_id`' do
        expect { client.create_group_member }
          .to raise_error(ArgumentError, /person_id/)
      end
    end

    subject(:resource) do
      client.create_group_member(
        group_id: 123,
        group_member_status: 1,
        group_role_id: 456,
        person_id: 123_456
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with(
          'GroupMembers',
          IsSystem: false,
          GroupId: 123,
          GroupMemberStatus: 1,
          GroupRoleId: 456,
          PersonId: 123_456
        ).and_call_original
      resource
    end
  end

  describe '#delete_group_member' do
    it 'returns nothing' do
      expect(client.delete_group_member(123)).to eq(nil)
    end

    it 'passes id' do
      expect(client).to receive(:delete).with('GroupMembers/123')
      client.delete_group_member(123)
    end
  end

  describe '#create_known_relationship' do
    context 'arguments' do
      it 'require `person_id`' do
        expect { client.create_known_relationship }
          .to raise_error(ArgumentError, /person_id/)
      end

      it 'require `related_person_id`' do
        expect { client.create_known_relationship }
          .to raise_error(ArgumentError, /related_person_id/)
      end

      it 'require `relationship_role_id`' do
        expect { client.create_known_relationship }
          .to raise_error(ArgumentError, /relationship_role_id/)
      end

    end

    subject(:resource) do
      client.create_known_relationship(
        person_id: 123,
        relationship_role_id: 1,
        related_person_id: 456,
      )
    end

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with('GroupMembers/KnownRelationship?personId=123&relatedPersonId=456&relationshipRoleId=1').and_call_original
      resource
    end
  end

end
