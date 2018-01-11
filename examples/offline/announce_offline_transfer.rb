require 'pp'
require 'nem'

req = JSON.parse(File.read('tx.json'), symbolize_names: true)
hash = Nem::Util::Deserializer.deserialize_transaction(req[:data])
pp Nem::Model::Transaction.new_from_account_transaction(hash)

node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

res = tx_endpoint.announce(req)

pp res
pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
