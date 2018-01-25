require 'spec_helper'

RSpec.describe RockRMS::Client::Batch, type: :model do
  include_context 'resource specs'


  describe '#list_batches' do
    it 'returns a array' do
      resource = client.list_batches
      expect(resource).to be_a(Array)
      expect(resource.first).to be_a(Hash)
    end
  end

  describe '#find_batch(id)' do
    it 'returns a hash' do
      puts client.find_batch(123)
      expect(client.find_batch(123)).to be_a(Hash)
    end

    it 'queries groups' do
      expect(client).to receive(:get).with('FinancialBatches/123')
        .and_call_original

      resource = client.find_batch(123)

      expect(resource["Id"]).to eq(123)
    end
  end



  describe '#create_batch' do
    context 'arguments' do

      it 'require `name`' do
        expect { client.create_batch }
          .to raise_error(ArgumentError, /name/)
      end

      it 'require `start_time`' do
        expect { client.create_batch }
          .to raise_error(ArgumentError, /start_time/)
      end

      it 'require `end_time`' do
        expect { client.create_batch }
          .to raise_error(ArgumentError, /end_time/)
      end

    end

    subject(:resource) {
      client.create_batch(
        name: "1",
        start_time: "1",
        end_time: "1",
        foreign_key: 1
      )
    }

    it 'returns integer' do
      expect(resource).to be_a(Integer)
    end

    it 'passes options' do
      expect(client).to receive(:post)
        .with('FinancialBatches', {
           "Name"=>"1",
            "BatchStartDateTime"=>"1",
            "BatchEndDateTime"=>"1",
            "ForeignKey"=>1
        })
        .and_call_original
      resource
    end
  end




  describe '#update_batch' do

    subject(:resource) {
      client.update_batch(123,{ 
        "Name" => "1",
        "ForeignKey": 1
      })
    }

    it 'returns nothing' do
      expect(client.update_batch(123)).to eq(nil)
    end

    it 'passes options' do
      expect(client).to receive(:patch)
        .with('FinancialBatches/123', {
            "Name"=>"1",
            "ForeignKey"=>1
        })
        .and_call_original
      resource
    end
  end



  # describe '#delete_batch' do
  #   it 'returns nothing' do
  #     expect(client.delete_batch(123)).to eq(nil)
  #   end

  #   it 'passes id' do
  #     expect(client).to receive(:delete).with('FinancialBatches/123')
  #     client.delete_batch(123)
  #   end
  # end

end
