require 'pp'
require 'nem'

node = Nem::Node.new(host: '104.128.226.60')

# new Debug Endpoint Object
debug_endpoint = Nem::Endpoint::Debug.new(node)

pp debug_endpoint.time_syncronization

pp debug_endpoint.timers

pp debug_endpoint.connections_incoming
pp debug_endpoint.connections_outgoing

# pp debug_endpoint.connections(:incoming)
# pp debug_endpoint.connections(:outgoing)
