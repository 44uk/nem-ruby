require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Debug Endpoint Object
debug_endpoint = Nem::Endpoint::Debug.new(node)

pp debug_endpoint.time_syncronization

pp debug_endpoint.timers

pp debug_endpoint.connections_incoming
pp debug_endpoint.connections_outgoing

# pp debug_endpoint.connections(:incoming)
# pp debug_endpoint.connections(:outgoing)
