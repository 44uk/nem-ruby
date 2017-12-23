require 'pp'
require 'nem'

# Nem.logger.level = Logger::DEBUG

# output debug log example
# Nem.configure do |conf|
#   conf.logger = Logger.new('./nem-ruby.log')
#   conf.logger.level = Logger::DEBUG
# end

# Create Node instance
node = Nem::Node.new(host: '104.128.226.60')

# # It returns Nem::NemRequestResult object.
pp node.heartbeat

pp node.status

# Also call Nem::Node#request method.
# The method receive [HTTP Method], [API Path], [Parameters]
# It returns hash which converted API JSON response.
# by API path /heartbeat, /status
pp node.request :get, 'heartbeat'

pp node.request :get, 'status'

pp node.request :get, 'account/get', address: 'TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4'

# ---- only accept local node
# node = Nem::Node.new

# Create local Node instance
# pp node.shutdown
