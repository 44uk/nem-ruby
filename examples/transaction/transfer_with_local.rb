require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
# connect localhost if no params
node = Nem::Node.new
tx_endpoint = Nem::Endpoint::Transaction.new(node)

# with plain message
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
# use #prepare method for local node without signature
res = tx_endpoint.prepare_announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
