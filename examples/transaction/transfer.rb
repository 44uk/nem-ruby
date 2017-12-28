require 'pp'
require 'nem'

# Library configuration
Nem.configure do |conf|
  conf.logger = Logger.new('./nem-ruby.log')
  conf.logger.level = Logger::DEBUG
  # you can set deadline(sec)
  # conf.deadline = 7200
  # set :mainnet if you'd like to use on mainnet!
  # conf.default_network = :mainnet # use on mainnet!
end

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

# with plain message
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
