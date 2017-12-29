require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG
Nem.debug = true

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Block Endpoint Object
block_endpoint = Nem::Endpoint::Block.new(node)

# somehow /block/get can't use.
# pp block_endpoint.find('fb5e76bf137eb27451926d29fd2b308e672e5d9ec405d9cbcd47cc0f83492cd0')

pp block_endpoint.at_public(1_223_559)
