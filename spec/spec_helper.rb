require 'bundler/setup'
require 'timecop'
require 'pp'
require 'pry'
require 'nem'

# Nem.configure do |conf|
#   conf.logger = Logger.new('./nem-ruby.log')
#   conf.logger.level = Logger::DEBUG
# end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
