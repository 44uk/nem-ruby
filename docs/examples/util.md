## Deserialize transaction

```ruby
require 'pp'
require 'nem'

# sender
A_PRIVATE_KEY = '260206d683962350532408e8774fd14870a173b7fba17f6b504da3dbc5f1cc9f'

# receiver
B_ADDRESS = 'TAWKJTUP4DWKLDKKS534TYP6G324CBNMXKBA4X7B'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
req = Nem::Request::Announce.new(tx, kp)

entity = req.to_entity

# You can also announce to nem Network later.
pp entity.to_json

# deserialize data into hash
pp Nem::Util::Deserializer.deserialize_transaction(req.to_entity[:data])
```
