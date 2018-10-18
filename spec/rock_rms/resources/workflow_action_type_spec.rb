require 'spec_helper'

RSpec.describe RockRMS::Client::WorkflowActionType, type: :model do
  include_context 'resource specs'

  describe '#list_workflow_action_types' do
    it 'returns a array' do
      resource = client.list_workflow_action_types
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_workflow_action_type(id)' do
    it 'returns a hash' do
      expect(client.find_workflow_action_type(2)).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('WorkflowActionTypes/2')
        .and_call_original

      resource = client.find_workflow_action_type(2)

      expect(resource[:id]).to eq(2)
    end

    it 'formats with WorkflowActionType' do
      response = double
      expect(RockRMS::Response::WorkflowActionType).to receive(:format).with(response)
      allow(client).to receive(:get).and_return(response)
      client.find_workflow_action_type(2)
    end
  end
end
