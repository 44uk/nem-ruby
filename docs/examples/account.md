## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Account.new(node)
```

## Find Address

```ruby
# find by address
pp endpoint.find('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# alias
pp endpoint.get('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# find by public key
pp endpoint.find_by_public_key('e59ef184a612d4c3c4d89b5950eb57262c69862b2f96e59c5043bf41765c482f')

# find forwarded by address
pp endpoint.find_forwarded('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# find forwarded by public key
pp endpoint.find_forwarded_by_public_key('e59ef184a612d4c3c4d89b5950eb57262c69862b2f96e59c5043bf41765c482f')
```

## Hervests

```ruby
pp endpoint.harvests('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
```

## Namespace / Mosaics

```ruby
# namespace
pp endpoint.namespace('TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR')

# fetch mosaic definition of account
pp endpoint.mosaic_definition('TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR')

# fetch owned mosaics of account
mosaics = account_endpoint.mosaic_owned('TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR')
pp mosaics

## can find by namespace
pp mosaics.find_by_namespace_id('tpico')

## can find by fqn
pp mosaics.find_by_fqn('tpico:test')
```

## Transactions

```ruby
## incomings
pp endpoint.transfers_incoming('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

## outgoings
pp endpoint.transfers_outgoing('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

## all
pp endpoint.transfers_all('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

## unconfirmed
pp endpoint.transfers_unconfirmed('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
```

## Status

```ruby
pp endpoint.status('TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64')
```

## Unlocked

```ruby
pp endpoint.unlocked_info
```

## Historical

```ruby
pp endpoint.historical('TDWWYDGQNBKSAJBSHZX7QWVX7WNVAWWB7HGPWRB2',
  start_height: 1245390,
  end_height: 1245400,
  increment: 1
)
```

## Generate Account / Lock, Unlock

The APIs allowed only Local NIS.

```ruby
## generate account
pp endpoint.generate

## lock account
pp endpoint.lock('__private_key__')

## unlock account
pp endpoint.unlock('__private_key__')
```
