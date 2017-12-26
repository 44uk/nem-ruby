require 'pp'
require 'nem'

node = Nem::Node.new(host: '104.128.226.60')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

req = File.read('tx.json')
res = tx_endpoint.announce(JSON.parse(req))

pp res
pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
