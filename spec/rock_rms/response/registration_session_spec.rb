require 'spec_helper'

RSpec.describe RockRMS::Response::RegistrationSession, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('registration_sessions.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'has the following keys' do
      response = result.first
      expected_keys = %i[
        registration_instance_id
        registration_data
        session_start_date_time
        expiration_date_time
        client_ip_address
        payment_gateway_reference
        session_status
        registration_id
        id
        guid
        created_date_time
        modified_date_time
        created_by_person_alias_id
        attributes
        attribute_values
        foreign_key
        foreign_id
      ]

      expect(response.keys).to eq(expected_keys)
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:guid]).to eq(p['Guid'])
        expect(r[:registration_instance_id]).to eq(p['RegistrationInstanceId'])
        expect(r[:registration_data]).to eq(p['RegistrationData'])
        expect(r[:session_start_date_time]).to eq(p['SessionStartDateTime'])
        expect(r[:expiration_date_time]).to eq(p['ExpirationDateTime'])
        expect(r[:client_ip_address]).to eq(p['ClientIpAddress'])
        expect(r[:payment_gateway_reference]).to eq(p['PaymentGatewayReference'])
        expect(r[:session_status]).to eq(p['SessionStatus'])
        expect(r[:registration_id]).to eq(p['RegistrationId'])
      end
    end
  end
end
