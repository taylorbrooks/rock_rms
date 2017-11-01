$LOAD_PATH.unshift(File.join(__FILE__, "..", "..", "lib"))

require 'rock_rms'
require 'webmock/rspec'
require_relative './support/rock_mock'

RSpec.configure do |config|
  config.before :suite do
    WebMock.disable_net_connect!
  end

  config.before :each do
    stub_request(:any, /rock/).to_rack(RockMock)
  end

  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
