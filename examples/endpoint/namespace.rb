require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Namespace Endpoint Object
ns_endpoint = Nem::Endpoint::Namespace.new(node)

pp ns_endpoint.find('alice')

pp ns_endpoint.root(882, page_size: 1)

pp ns_endpoint.mosaic_definition('tpico')
