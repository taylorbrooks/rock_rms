require 'spec_helper'

RSpec.describe RockRMS::Responses::PhoneNumber, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('phone_numbers.json')) }

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
        expect(r[:person_id]).to eq(p['PersonId'])
        expect(r[:number]).to eq(p['Number'])
        expect(r[:formatted]).to eq(p['NumberFormatted'])
        expect(r[:formatted_with_cc]).to eq(p['NumberFormattedWithCountryCode'])
      end
    end
  end
end
