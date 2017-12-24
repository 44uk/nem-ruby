require 'pp'
require 'nem'

node = Nem::Node.new(host: '104.128.226.60')

# new Timesync Endpoint Object
ts_endpoint = Nem::Endpoint::Timesync.new(node)

pp ts_endpoint.network_time
