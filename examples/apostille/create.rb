require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

FIXTURES_PATH = File.expand_path('../../../spec/fixtures', __FILE__)

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

file = File.open("#{FIXTURES_PATH}/nemLogoV2.png")
apo = Nem::Apostille.new(kp, file, :sha256,
  multisig: false,
  signed: false,
  network: :testnet
)
tx = apo.transaction
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
pp "ApostilleFormat: #{apo.apostille_format(res.transaction_hash)}"

FileUtils.cp(file.path, apo.apostille_format(res.transaction_hash))
