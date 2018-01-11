require 'pp'
require 'nem'

# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# receiver
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')

tx.mosaics << Nem::Mosaic::Xem.new(1_000)
tx.mosaics << Nem::Mosaic::DimCoin.new(100)
tx.mosaics << Nem::Mosaic::DimToken.new(10)
tx.mosaics << Nem::Mosaic::EcobitEco.new(10_000)

req = Nem::Request::Announce.new(tx, kp)
data = req.to_entity[:data]

# serialized transaction data
pp data

# deserialize data into hash
hash = Nem::Util::Deserializer.deserialize_transaction(data)
pp Nem::Model::Transaction.new_from_account_transaction(hash)
