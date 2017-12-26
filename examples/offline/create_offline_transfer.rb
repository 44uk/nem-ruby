require 'pp'
require 'nem'

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

# recipient
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck! Offline transfer.')
req = Nem::Request::Announce.new(tx, kp)

# signed announce
pp data = req.to_entity
pp 'save as tx.json'
File.write 'tx.json', data.to_json
