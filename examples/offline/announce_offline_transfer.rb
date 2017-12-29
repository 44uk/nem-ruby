require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

req = File.read('tx.json')
res = tx_endpoint.announce(JSON.parse(req))

pp res
pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
