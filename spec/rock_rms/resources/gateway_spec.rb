require 'spec_helper'

RSpec.describe RockRMS::Client::Gateway, type: :model do
  include_context 'resource specs'

  describe '#list_gateways' do
    it 'returns a array' do
      resource = client.list_gateways
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end
end
