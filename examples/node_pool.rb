require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# Create node pool
nodes = Nem::NodePool.new([
  Nem::Node.new(host: 'dummy1.example.com'),
  Nem::Node.new(host: 'dummy2.example.com'),
  Nem::Node.new(host: 'bigalice2.nem.ninja')
])

# Create from hash definitions
# nodes = Nem::NodePool.from_hash([
#   {host: 'dummy1.example.com'},
#   {host: 'dummy2.example.com'},
#   {host: 'bigalice2.nem.ninja'}
# ])

account_endpoint = Nem::Endpoint::Account.new(nodes)

# switch to bigalice2.nem.ninja
pp account_endpoint.find('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
