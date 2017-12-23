require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# multisig
M_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'

# cosignatory(A)
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# cosignatory(B)
B_PUBLIC_KEY  = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: '104.128.226.60')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

msig_cosigratories = [
  Nem::Transaction::MultisigCosignatoryModification.new(:add, B_PUBLIC_KEY)
]
relative_change = 1
mtx = Nem::Transaction::MultisigAggregateModification.new(msig_cosigratories, relative_change)
tx = Nem::Transaction::Multisig.new(mtx, M_PUBLIC_KEY)
tx_endpoint = Nem::Endpoint::Transaction.new(node)

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
