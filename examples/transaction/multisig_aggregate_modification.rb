require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# multisig
M_PRIVATE_KEY = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'

# cosignatory(A)
A_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'

kp = Nem::Keypair.new(M_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

msig_cosignatories = [
  Nem::Transaction::MultisigCosignatoryModification.new(:add, A_PUBLIC_KEY)
]
relative_change = 1
tx = Nem::Transaction::MultisigAggregateModification.new(
  msig_cosignatories,
  relative_change
)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
