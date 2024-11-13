require 'spec_helper'

RSpec.describe RockRMS::Client::ContentChannel, type: :model do
  include_context 'resource specs'

  describe '#list_content_channels(options = {})' do
    it 'returns a list of content channels' do
      result = client.list_content_channels
      expect(result).to be_an(Array)
      expect(result.first).to have_key(:id)
      expect(result.first).to have_key(:name)
    end
  end

  describe '#find_content_channel(id)' do
    it 'returns a hash' do
      expect(client.find_content_channel(123)).to be_a(Hash)
    end

    it 'queries' do
      expect(client).to receive(:get).with('ContentChannels/123')
        .and_call_original

      resource = client.find_content_channel(123)

      expect(resource[:id]).to eq(345)
    end

    it 'formats with ContentChannel' do
      response = double
      expect(RockRMS::Response::ContentChannel).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_content_channel(123)
    end
  end

  describe '#update_content_channel' do
    it 'does not raise error' do
      expect { client.update_content_channel(id: 123) }.not_to raise_error
    end

    it 'sends a patch request' do
      expect(client).to receive(:patch).with('ContentChannels/123', { foreign_key: 3925 })
      client.update_content_channel(id: 123, foreign_key: 3925)
    end
  end
end
