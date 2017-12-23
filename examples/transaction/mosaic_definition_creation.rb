require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# mosaic creator
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
A_PUBLIC_KEY = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'
A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

mosaic_id = Nem::Model::MosaicId.new(
  namespace_id: 'sushi',
  name: 'maguro'
)

properties = Nem::Model::MosaicProperties.new(
  divisibility: 0,
  initial_supply: 10_000,
  supply_mutable: true,
  transferable: true
)

levy = Nem::Model::MosaicLevy.new(
  type: 1,
  recipient: A_ADDRESS,
  mosaic_id: Nem::Model::MosaicId.new(
    namespace_id: 'nem',
    name: 'xem'
  ),
  fee: 1_000
)

definition = Nem::Model::MosaicDefinition.new(
  creator: A_PUBLIC_KEY,
  id: mosaic_id,
  description: 'Japanese Soul food SHUSHI.',
  properties: properties,
  levy: levy
)

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: '104.128.226.60')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

tx = Nem::Transaction::MosaicDefinitionCreation.new(definition)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
