require 'spec_helper'

RSpec.describe RockRMS::Client::ContentChannelItem, type: :model do
  include_context 'resource specs'

  describe '#list_content_channel_items(options = {})' do
    it 'returns a list of content channel items' do
      result = client.list_content_channel_items
      expect(result).to be_an(Array)
      expect(result.first).to have_key(:id)
      expect(result.first).to have_key(:title)
    end
  end
end
