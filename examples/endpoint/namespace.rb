require 'pp'
require 'nem'

node = Nem::Node.new(host: '104.128.226.60')

# new Namespace Endpoint Object
ns_endpoint = Nem::Endpoint::Namespace.new(node)

pp ns_endpoint.find('alice')

pp ns_endpoint.root(882, page_size: 1)

pp ns_endpoint.mosaic_definition('tpico')
