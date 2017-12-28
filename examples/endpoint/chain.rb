require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Block Endpoint Object
chain_endpoint = Nem::Endpoint::Chain.new(node)

pp chain_endpoint.height

pp chain_endpoint.score

pp chain_endpoint.last_block
