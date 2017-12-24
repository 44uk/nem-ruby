require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# Create node pool
nodes = Nem::NodePool.new([
  Nem::Node.new(host: 'dummy1.example.com'),
  Nem::Node.new(host: 'dummy2.example.com'),
  Nem::Node.new(host: '104.128.226.60')
])

# Create from hash definitions
# nodes = Nem::NodePool.from_hash([
#   {host: 'dummy1.example.com'},
#   {host: 'dummy2.example.com'},
#   {host: '104.128.226.60'}
# ])

account_endpoint = Nem::Endpoint::Account.new(nodes)

# switch to 104.128.226.60
pp account_endpoint.find('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
