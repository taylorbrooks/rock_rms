$LOAD_PATH.unshift(File.join(__FILE__, "..", "..", "lib"))

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
