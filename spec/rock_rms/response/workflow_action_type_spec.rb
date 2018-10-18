require 'spec_helper'

RSpec.describe RockRMS::Response::WorkflowActionType, type: :model do
  let(:parsed) { JSON.parse(FixturesHelper.read('workflow_action_types.json')) }

  describe '.format' do
    subject(:result) { described_class.format(parsed) }

    context 'when response is array' do
      it 'returns an array' do
        expect(described_class.format([])).to be_a(Array)
      end
    end

    it 'translates keys' do
      result.take(1).zip(parsed) do |r, p|
        expect(r[:id]).to eq(p['Id'])
        expect(r[:name]).to eq(p['Name'])
        expect(r[:order]).to eq(p['Order'])
        expect(r[:activity_type_id]).to eq(p['ActivityTypeId'])
      end
    end
  end
end
