require 'pp'
require 'nem'

node = Nem::Node.new

# new Local Endpoint Object
laccount_endpoint = Nem::Endpoint::Local::Account.new(node)

pp laccount_endpoint.transfers('00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1', dir: :in)

pp laccount_endpoint.transfers('00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1', dir: :out)

pp laccount_endpoint.transfers('00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1', dir: :all)

lchain_endpoint = Nem::Endpoint::Local::Chain.new(node)

pp lchain_endpoint.blocks_after(1_223_559)
