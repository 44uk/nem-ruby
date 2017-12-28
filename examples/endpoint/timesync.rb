require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Timesync Endpoint Object
ts_endpoint = Nem::Endpoint::Timesync.new(node)

pp ts_endpoint.network_time
