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

# with future timestamp
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 0, 'Good luck! Set future timestamp',
  timestamp: Time.now + 300,
  deadline:  Time.now + 3900
)

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

# # It occurs "FAILURE_TIMESTAMP_TOO_FAR_IN_FUTURE"
pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"

# Save signed transaction for announcing after 5 mins.
pp data = req.to_entity
pp 'save as tx.json'
File.write 'tx.json', data.to_json
