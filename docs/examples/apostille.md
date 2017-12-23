## Public Apostille

### Create

```ruby
require 'pp'
require 'nem'

FIXTURES_PATH = File.expand_path('../../spec/fixtures', __FILE__)

# sender
A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

kp = Nem::Keypair.new(A_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

file = File.open("#{FIXTURES_PATH}/nemLogoV2.png")
apo = Nem::Apostille.new(kp, file, :sha1,
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
```

### Audit

```ruby
require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)

# transaction hash from Filename
tx_hash = 'c035c2603356852687c4730fbc6f8d21da3af7c4c0eb8b3619bc9ecdc833255a'
tx = tx_endpoint.find(tx_hash)

# NOTE: it may return "Hash was not found in cache"
# because of NIS not supporting caching transactions.
# 'fe4e545902cde315617a435ebfd5fe8875d699e2f2363262f5'
apostille_hash = tx.message.payload
file = File.open("#{FIXTURES_PATH}/nemLogoV2 -- Apostille TX c035c2603356852687c4730fbc6f8d21da3af7c4c0eb8b3619bc9ecdc833255a -- Date 2017-12-18.png")

apa = Nem::ApostilleAudit.new(file, apostille_hash)
pp apa.valid? ? 'OK, Valid Apostille!' : 'Bad, Invalid Apostille!'
```
