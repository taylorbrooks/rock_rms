require 'spec_helper'

RSpec.describe RockRMS::Client::WorkflowType, type: :model do
  include_context 'resource specs'

  describe '#list_workflow_types' do
    it 'returns a array' do
      resource = client.list_workflow_types
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_workflow_type(id)' do
    it 'returns a hash' do
      expect(client.find_workflow_type(123)).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('WorkflowTypes/123')
        .and_call_original

      resource = client.find_workflow_type(123)

      expect(resource[:id]).to eq(123)
    end

    it 'formats with WorkflowType' do
      response = double
      expect(RockRMS::Response::WorkflowType).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_workflow_type(123)
    end
  end
end
