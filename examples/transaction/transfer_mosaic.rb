require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')

tx.mosaics << Nem::Mosaic::Xem.new(1)

# fetch mosaic definition
ns_endpoint = Nem::Endpoint::Namespace.new(node)
mo_def = ns_endpoint.mosaic_definition('kon').first
moa = Nem::Model::MosaicAttachment.new(
  mosaic_id: mo_def.id,
  properties: mo_def.properties,
  quantity: 1
)
tx.mosaics << moa

# define custom mosaic attachment
class KonHeart < Nem::Model::MosaicAttachment
  def initialize(quantity)
    # set values what you defined
    mosaic_id = Nem::Model::MosaicId.new(
      namespace_id: 'kon',
      name: 'heart'
    )
    # set values what you defined
    properties = Nem::Model::MosaicProperties.new(
      divisibility: 3,
      initial_supply: 100_000_000
    )
    super(
      mosaic_id: mosaic_id,
      properties: properties,
      quantity: quantity
    )
  end
end
tx.mosaics << KonHeart.new(1)

pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
