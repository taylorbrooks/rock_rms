require 'spec_helper'

RSpec.describe RockRMS::Client::Campus, type: :model do
  include_context 'resource specs'

  describe '#find_campus(id)' do
    it 'returns a hash' do
      expect(client.find_campus(1)).to be_a(Hash)
    end

    it 'queries campuses' do
      expect(client).to receive(:get).with('Campuses/1').and_call_original

      resource = client.find_campus(1)

      expect(resource[:id]).to eq(1)
    end

    it 'formats with Campus' do
      response = double
      expect(RockRMS::Response::Campus).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_campus(1)
    end
  end

end
