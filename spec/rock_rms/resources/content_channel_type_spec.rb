require 'spec_helper'

RSpec.describe RockRMS::Client::ContentChannelType, type: :model do
  include_context 'resource specs'

  describe '#list_content_channel_types(options = {})' do
    it 'returns a list of content channel types' do
      result = client.list_content_channel_types
      expect(result).to be_an(Array)
      expect(result.first).to have_key(:id)
      expect(result.first).to have_key(:name)
    end
  end
end
