require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :environment do
  require 'dotenv'
  Dotenv.load

  $LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
  require 'rock_rms'
end

desc "Launch a pry shell with libraries loaded"
task :pry => :environment do
  if ENV['ROCK_USERNAME']
    @client = RockRMS::Client.new(
      url: ENV['ROCK_API_URL'],
      username: ENV['ROCK_USERNAME'],
      password: ENV['ROCK_PASSWORD'],
      logger: !!ENV['CLIENT_LOGGER']
    )
  end

  require 'pry'
  Pry.start
end
