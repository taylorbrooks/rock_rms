require 'spec_helper'

RSpec.describe RockRMS::Client::SavedPaymentMethod, type: :model do
  include_context 'resource specs'

  describe '#list_saved_payment_methods' do
    it 'returns a array' do
      resource = client.list_saved_payment_methods
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#delete_saved_payment_method' do
    it 'returns nothing' do
      expect(client.delete_saved_payment_method(123)).to eq(nil)
    end

    it 'passes id' do
      expect(client).to receive(:delete).with('FinancialPersonSavedAccounts/123')
      client.delete_saved_payment_method(123)
    end
  end
end
