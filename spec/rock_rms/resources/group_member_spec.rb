require 'spec_helper'

RSpec.describe RockRMS::Client::GroupMember, type: :model do
  include_context 'resource specs'

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

    subject(:resource) {
      client.create_group_member(
        group_id: 123,
        group_member_status: 1,
        group_role_id: 456,
        person_id: 123456
      )
    }

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with('GroupMembers', {
          IsSystem: false,
          GroupId: 123,
          GroupMemberStatus: 1,
          GroupRoleId: 456,
          PersonId: 123456
        })
        .and_call_original
      resource
    end
  end
end
