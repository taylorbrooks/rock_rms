require 'spec_helper'
require 'rack/utils'

RSpec.describe RockRMS::Error do
  let(:client) do
    RockRMS::Client.new(
      url: 'http://some-rock-uri.com',
      username: 'test',
      password: 'test',
      logger: false
    )
  end

  CODES = Rack::Utils::HTTP_STATUS_CODES.keys.freeze

  def stub(code, body)
    stub_request(:any, /rock/).to_return(status: code, body: body)
  end

  def expect_failure(code, body)
    url = 'http://some-rock-uri.com/api/Auth/Login'

    expect {
      client.get('anything')
    }.to raise_error(RockRMS::Error, /#{code}: #{url} #{body}/)
  end

  def expect_success
    expect { client.get('anything') }.to_not raise_error
  end

  context 'informational responses' do
    CODES.grep(100..199).each do |code|
      it "does not raise error for #{code}" do
        stub(code, '{}')
        expect_success
      end
    end
  end

  context 'success responses' do
    CODES.grep(200..299).each do |code|
      it "does not raise error for #{code}" do
        stub(code, '{}')
        expect_success
      end
    end
  end

  context 'redirection responses' do
    CODES.grep(300..399).each do |code|
      it "does not raise error for #{code}" do
        stub(code, '')
        expect_success
      end
    end
  end

  context 'client error responses' do
    CODES.grep(400..499).each do |code|
      it "raises exception for #{code}" do
        stub(code, 'test client error')
        expect_failure(code, 'test client error')
      end
    end
  end

  context 'server error responses' do
    CODES.grep(500..599).each do |code|
      it "raises exception for #{code}" do
        stub(code, 'test client error')
        expect_failure(code, 'test client error')
      end
    end
  end

  context 'html error responses' do
    it 'raises exception for internal error' do
      body = File.read('spec/rock_rms/fixtures/internal_error.html')
      stub(200, body)
      expect_failure(500, 'Unknown API error.')
    end

    it 'raises exception for not found error' do
      body = File.read('spec/rock_rms/fixtures/not_found_error.html')
      stub(200, body)
      expect_failure(404, 'Page not found.')
    end
  end
end
