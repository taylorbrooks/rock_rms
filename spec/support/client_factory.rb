RSpec.shared_context 'resource specs' do
  let(:attrs) do
    {
      url: 'http://some-rock-uri.com',
      username: 'test',
      password: 'test'
    }
  end
  let(:attrs_without_logging) { attrs.merge(logger: false) }

  let(:client) { RockRMS::Client.new(attrs_without_logging) }
end
