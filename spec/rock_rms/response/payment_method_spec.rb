require 'spec_helper'

RSpec.describe RockRMS::Response::PaymentMethod, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('payment_methods.json')) }

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
        expect(r[:exp_month]).to eq(p['ExpirationMonth'])
        expect(r[:exp_year]).to eq(p['ExpirationYear'])
        expect(r[:foreign_key]).to eq(p['ForeignKey'])
        expect(r[:payment_type_id]).to eq(p['CurrencyTypeValueId'])
        expect(r[:masked_number]).to eq(p['AccountNumberMasked'])
      end
    end
  end
end
