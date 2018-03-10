## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Transaction.new(node)
kp = Nem::Keypair.new(A_PRIVATE_KEY)
```

## Transfer

### Version1(XEM transfer)

```ruby
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

### Version2(mosaic transfer)

```ruby
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')

# define custom mosaic attachment if you already know mosaic definition
class KonHeart
  include Nem::Mixin::MosaicAttachable
  namespace_id 'kon'
  name 'heart'
  divisibility 3
  initial_supply 100_000_000
end
tx.mosaics << KonHeart.new(1)

# fetch mosaic definition
ns_endpoint = Nem::Endpoint::Namespace.new(node)
mo_def = ns_endpoint.mosaic_definition('kon').first
moa = Nem::Model::MosaicAttachment.new(
  mosaic_id: mo_def.id,
  properties: mo_def.properties,
  quantity: 1
)
tx.mosaics << moa

# send xem as mosaic
tx.mosaics << Nem::Mosaic::Xem.new(1)

pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

## Importance Transfer

```ruby
tx = Nem::Transaction::ImportanceTransfer.new(B_PUBLIC_KEY, :activate)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

## Multisig Signature

```ruby
account_endpoint = Nem::Endpoint::Account.new(node)
txes = account_endpoint.transfers_unconfirmed(B_ADDRESS)

unless txes.size > 0
  puts 'There are no transactions to sign.'
  exit
end

need_sig_tx = txes.first
pp "Unconfirmed Transaction Hash: #{need_sig_tx.hash}"

tx = Nem::Transaction::MultisigSignature.new(need_sig_tx.hash, M_ADDRESS, B_PUBLIC_KEY)

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

## Provision Namespace

```ruby
tx = Nem::Transaction::ProvisionNamespace.new('sushi')
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

## Mosaic

### Creation

```ruby
mosaic_id = Nem::Model::MosaicId.new(
  namespace_id: 'sushi',
  name: 'maguro'
)

properties = Nem::Model::MosaicProperties.new(
  divisibility: 0,
  initial_supply: 10_000,
  supply_mutable: true,
  transferable: true
)

levy = Nem::Model::MosaicLevy.new(
  type: 1,
  recipient: A_ADDRESS,
  mosaic_id: Nem::Model::MosaicId.new(
    namespace_id: 'nem',
    name: 'xem'
  ),
  fee: 1_000
)

definition = Nem::Model::MosaicDefinition.new(
  creator: A_PUBLIC_KEY,
  id: mosaic_id,
  description: 'Japanese Soul food SHUSHI.',
  properties: properties,
  levy: levy
)

tx = Nem::Transaction::MosaicDefinitionCreation.new(definition)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

### Supply Change

```ruby
mosaic_id = Nem::Model::MosaicId.new(
  namespace_id: 'sushi',
  name: 'maguro'
)

tx = Nem::Transaction::MosaicSupplyChange.new(mosaic_id, :increase, 1_000)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

## Multisig Aggregate Modification

```ruby
msig_cosignatories = [
  Nem::Transaction::MultisigCosignatoryModification.new(:add, A_PUBLIC_KEY)
]
relative_change = 1
tx = Nem::Transaction::MultisigAggregateModification.new(msig_cosignatories, relative_change)
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

### Add cosignatory

```ruby
msig_cosigratories = [
  Nem::Transaction::MultisigCosignatoryModification.new(:add, B_PUBLIC_KEY)
]
relative_change = 1
mtx = Nem::Transaction::MultisigAggregateModification.new(msig_cosigratories, relative_change)
tx = Nem::Transaction::Multisig.new(mtx, M_PUBLIC_KEY)

req = Nem::Request::Announce.new(tx, kp)
res = endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```

### Local node

```ruby
tx = Nem::Transaction::Transfer.new(B_ADDRESS, 1, 'Good luck!')
pp "Fee: #{tx.fee.to_i}"

req = Nem::Request::Announce.new(tx, kp)
# use #prepare_announce method for local node without signature
res = endpoint.prepare_announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
```
