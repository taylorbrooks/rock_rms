$:.push File.expand_path('../lib', __FILE__)
require 'rock_rms/version'
require 'base64'

Gem::Specification.new do |s|
  s.name          = 'rock_rms'
  s.version       = RockRMS::VERSION
  s.authors       = ['Taylor Brooks']
  s.email         = ['dGJyb29rc0BnbWFpbC5jb20='].map { |e| Base64.decode64(e) }
  s.homepage      = 'https://github.com/taylorbrooks/rock_rms'
  s.summary       = 'A Ruby wrapper for the Rock RMS API'
  s.description   = 'A Ruby wrapper for the Rock RMS API -- a church management platform, simplified.'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test)/})

  s.required_ruby_version = '~> 2.3'

  s.require_paths = ['lib']

  s.add_runtime_dependency     'faraday'
  s.add_runtime_dependency     'faraday_middleware'
  s.add_runtime_dependency     'faraday_middleware-parse_oj'
  s.add_runtime_dependency     'json'

  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake', '~> 12.3.3'
  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'sinatra', '~> 2.0'
  s.add_development_dependency 'webmock', '~> 3.1'
end
