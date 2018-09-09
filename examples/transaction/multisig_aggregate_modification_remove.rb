require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# multisig
M_PUBLIC_KEY = 'e41f6fcfe6e311b8302f6f3d9b856e059f2a1ba7012159b8518328d5c584551b'

# initiator(A)
A_PRIVATE_KEY = '5a713ebe837e3f426489374d321d7255ba5de868af6be745636a348608177f87'

# cosignatory(C) to be remove from cosignatories
C_PUBLIC_KEY = '93084f6772ead71af12acad0f2b1068919ad5f709eb0ef3f8fbe2913fdde75f5'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

modifications = [
  Nem::Transaction::MultisigCosignatoryModification.new(:remove, C_PUBLIC_KEY)
]

relative_change = 0

mamtx = Nem::Transaction::MultisigAggregateModification.new(
  modifications,
  relative_change
)

tx = Nem::Transaction::Multisig.new(mamtx, M_PUBLIC_KEY)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
