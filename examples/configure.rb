require 'nem'

# Library configuration
Nem.configure do |conf|
  # set logger
  conf.logger = Logger.new('./nem-ruby.log')
  conf.logger.level = Logger::DEBUG

  # debug flag
  conf.debug = true

  # you can set deadline(sec)
  conf.default_deadline = 7200

  # set :mainnet if you'd like to use on mainnet!
  conf.default_network = :mainnet # use on mainnet!
end
