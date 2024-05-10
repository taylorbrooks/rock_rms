require 'spec_helper'

RSpec.describe RockRMS::Response::RecurringDonation, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('recurring_donations.json')) }

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
        active
        financial_gateway_id
        foreign_key
        frequency
        end_date
        gateway_schedule_id
        next_payment_date
        payment_details
        person_id
        start_date
        transaction_details
        transaction_code
        transaction_type_id
        summary
        status
        status_message
        id
        guid
        created_date_time
        modified_date_time
        created_by_person_alias_id
        attributes
        attribute_values
      ]

      expect(response.keys).to eq(expected_keys)
    end

    it 'translates keys' do
      result.zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:guid]).to eq(p['Guid'])
        expect(r[:active]).to eq(p['IsActive'])
        expect(r[:financial_gateway_id]).to eq(p['FinancialGatewayId'])
        expect(r[:gateway_schedule_id]).to eq(p['GatewayScheduleId'])
        expect(r[:foreign_key]).to eq(p['ForeignKey'])
        expect(r[:frequency]).to eq('monthly')
        expect(r[:next_payment_date]).to eq(p['NextPaymentDate'])
        expect(r[:person_id]).to eq(p['AuthorizedPersonAliasId'])
        expect(r[:transaction_details]).to eq(
          RockRMS::Response::RecurringDonationDetails.format(p['ScheduledTransactionDetails'])
        )
        expect(r[:transaction_code]).to eq(p['TransactionCode'])
      end
    end
  end
end
