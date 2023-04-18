require 'spec_helper'

RSpec.describe RockRMS::Client do
  let(:attrs) do
    {
      url: 'http://some-rock-uri.com',
      username: 'test',
      password: 'test'
    }
  end
  let(:attrs_without_logging) { attrs.merge(logger: false) }
  let(:attrs_without_authentication)  do
    {
      url: 'http://some-rock-uri.com',
      username: nil,
      password: nil,
      authorization_token: nil
    }
  end

  subject(:client) { described_class.new(**attrs_without_logging) }
  let(:noisy_client) { described_class.new(**attrs) }

  describe '#initialize' do
    it 'requries `url` param' do
      expect { described_class.new }
        .to raise_error(ArgumentError, /url/)
    end

    it 'requries either `username` and `password` params or `authorization_token` param' do
      expect { described_class.new(attrs_without_authentication) }
        .to raise_error(ArgumentError, /username and password or authorization_token/)
    end

    context 'url' do
      it 'expects a valid URI' do
        expect do
          described_class.new(url: 'test', username: 'test', password: 'test')
        end.to raise_error(URI::BadURIError)
      end
    end
  end

  context 'defaults' do
    it '`logger` is `true`' do
      expect(noisy_client.logger).to be_truthy
    end

    it 'sets base api url' do
      expect(client.url).to eq('http://some-rock-uri.com/api/')
    end
  end

  shared_examples 'param request' do |verb|
    let(:endpoint) { "#{verb}_test" }
    let(:url) { "http://some-rock-uri.com/api/#{endpoint}" }

    before do
      stub_request(:any, /_test/).to_return(body: response_body.to_json)
    end

    it 'requests at `path` argument' do
      client.public_send(verb, endpoint)

      expect(WebMock).to have_requested(verb, url)
    end

    it 'passes request parameters' do
      client.public_send(verb, endpoint, request_params)

      expect(WebMock).to have_requested(verb, url).with(query: request_params)
    end

    it 'returns parsed response body' do
      expect(client.public_send(verb, endpoint)).to eq(response_body)
    end
  end

  shared_examples 'body request' do |verb|
    let(:body) { { 'test' => 123 } }
    let(:endpoint) { "#{verb}_test" }
    let(:url) { "http://some-rock-uri.com/api/#{endpoint}" }

    let(:do_request) { client.public_send(verb, endpoint, body) }

    before do
      stub_request(:any, /_test/).to_return(body: body.to_json)
    end

    it 'requests at `path` argument' do
      do_request

      expect(WebMock).to have_requested(verb, url)
    end

    it 'passes request body' do
      do_request

      expect(WebMock)
        .to have_requested(verb, url)
        .with(body: body)
    end

    it 'returns parsed response body' do
      expect(do_request).to eq(body)
    end
  end

  describe '#get(path, options = {})' do
    let(:request_params) { { 'test' => 123 } }
    let(:response_body) { request_params }

    include_examples 'param request', :get
  end

  describe '#delete(path, options = {})' do
    let(:request_params) { { 'test' => 123 } }
    let(:response_body) { {} }

    include_examples 'param request', :delete
  end

  describe '#patch(path, options = {})' do
    include_examples 'body request', :patch
  end

  describe '#post(path, options = {})' do
    include_examples 'body request', :post
  end

  describe '#put(path, options = {})' do
    include_examples 'body request', :put
  end
end
