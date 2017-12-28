require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Mosaic Endpoint Object
mo_endpoint = Nem::Endpoint::Mosaic.new(node)

pp mo_endpoint.supply('nembar:vip')
