require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

req = JSON.parse(File.read('tx.json'))
res = tx_endpoint.announce(req)

pp res
pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
