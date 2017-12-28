require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# mosaic owner
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

mosaic_id = Nem::Model::MosaicId.new(
  namespace_id: 'sushi',
  name: 'maguro'
)

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')

tx = Nem::Transaction::MosaicSupplyChange.new(mosaic_id, :increase, 1_000)
tx_endpoint = Nem::Endpoint::Transaction.new(node)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
