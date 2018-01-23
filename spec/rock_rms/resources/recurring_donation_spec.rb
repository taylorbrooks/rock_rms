require 'spec_helper'

RSpec.describe RockRMS::Client::RecurringDonation, type: :model do
  include_context 'resource specs'

  describe '#list_recurring_donations(options = {})' do
    it 'returns a array of hashes' do
      resource = client.list_recurring_donations
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end

    it 'queries recurring donations' do
      expect(client).to receive(:get)
        .with('FinancialScheduledTransactions', {})
        .and_call_original
      client.list_recurring_donations
    end

    it 'formats with RecurringDonation' do
      response = double
      expect(RockRMS::Responses::RecurringDonation).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.list_recurring_donations
    end
  end

  describe '#find_recurring_donation(id)' do
    it 'returns a hash' do
      expect(client.find_recurring_donation(12345)).to be_a(Hash)
    end

    it 'queries recurring donations' do
      expect(client).to receive(:get).with('FinancialScheduledTransactions/12345')
        .and_call_original

      resource = client.find_recurring_donation(12345)

      expect(resource[:id]).to eq(12345)
    end

    it 'formats with RecurringDonation' do
      response = double
      expect(RockRMS::Responses::RecurringDonation).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_recurring_donation(12345)
    end
  end
end
