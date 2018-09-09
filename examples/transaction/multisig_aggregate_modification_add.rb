require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# multisig
M_PRIVATE_KEY = '5dde437eadf98b4c97a3ef2fbfaa11211a1bce5fba6c30e383872a85cd6971ac'

# cosignatory(A)
A_PUBLIC_KEY  = '9c345085d83b12220b351807643d35d179feaa871147c0245e95b7a5284dcc34'

# cosignatory(B)
B_PUBLIC_KEY  = 'c96e5efb62475dd1686ab525be6837ca932e278f82412d40155e2f0e62ad24c0'

# cosignatory(C)
C_PUBLIC_KEY  = '93084f6772ead71af12acad0f2b1068919ad5f709eb0ef3f8fbe2913fdde75f5'

kp = Nem::Keypair.new(M_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

modifications = [
  Nem::Transaction::MultisigCosignatoryModification.new(:add, A_PUBLIC_KEY),
  Nem::Transaction::MultisigCosignatoryModification.new(:add, B_PUBLIC_KEY),
  Nem::Transaction::MultisigCosignatoryModification.new(:add, C_PUBLIC_KEY)
]

relative_change = 2
tx = Nem::Transaction::MultisigAggregateModification.new(
  modifications,
  relative_change
)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
