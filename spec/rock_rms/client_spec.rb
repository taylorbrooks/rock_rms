require 'spec_helper'

RSpec.describe RockRMS::Client do
  subject(:client) {
    described_class.new(
      url: 'http://some-rock-uri.com',
      username: 'test',
      password: 'test',
    )
  }

  describe '#initialize' do
    it 'requries `url` param' do
      expect { described_class.new }
        .to raise_error(ArgumentError, /url/)
    end

    it 'requries `username` param' do
      expect { described_class.new }
        .to raise_error(ArgumentError, /username/)
    end

    it 'requries `password` param' do
      expect { described_class.new }
        .to raise_error(ArgumentError, /password/)
    end

    context 'url' do
      it 'expects a valid URI' do
        expect {
          described_class.new(url: 'test', username: 'test', password: 'test')
        }.to raise_error(URI::InvalidURIError)
      end
    end
  end

  context 'defaults' do
    it '`logger` is `true`' do
      expect(client.logger).to be_truthy
    end

    it 'sets base api url' do
      expect(client.url).to eq('http://some-rock-uri.com/api/')
    end
  end
end
