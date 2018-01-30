require 'spec_helper'

RSpec.describe RockRMS::Response::Campus, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('campuses.json')) }

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
        expect(r[:description]).to eq(p['Description'])
        expect(r[:short_code]).to eq(p['ShortCode'])
        expect(r[:url]).to eq(p['Url'])
        expect(r[:location_id]).to eq(p['LocationId'])
        expect(r[:phone_number]).to eq(p['PhoneNumber'])
        expect(r[:service_times]).to eq(p['ServiceTimes'])
        expect(r[:guid]).to eq(p['Guid'])
      end
    end
  end
end
