require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Node Endpoint Object
node_endpoint = Nem::Endpoint::Node.new(node)

pp node_endpoint.info

pp node_endpoint.extended_info

pp node_endpoint.max_chain_height

pp node_endpoint.experiences

pp node_endpoint.peerlist_all
pp node_endpoint.peerlist_reachable
pp node_endpoint.peerlist_active

# you can also call this way
# pp node_endpoint.peerlist(:all)
# pp node_endpoint.peerlist(:reachable)
# pp node_endpoint.peerlist(:active)
