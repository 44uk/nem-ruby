require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

node = Nem::Node.new(host: '104.128.226.60')

# new Block Endpoint Object
chain_endpoint = Nem::Endpoint::Chain.new(node)

pp chain_endpoint.height

pp chain_endpoint.score

pp chain_endpoint.last_block
