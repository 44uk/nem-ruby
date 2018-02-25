require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# multisig
M_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'

# cosignatory
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

ttx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
tx = Nem::Transaction::Multisig.new(ttx, M_PUBLIC_KEY)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
