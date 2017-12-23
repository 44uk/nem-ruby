require 'pp'
require 'nem'

node = Nem::Node.new(host: '104.128.226.60')

# new Mosaic Endpoint Object
mo_endpoint = Nem::Endpoint::Mosaic.new(node)

pp mo_endpoint.supply('nembar:vip')
