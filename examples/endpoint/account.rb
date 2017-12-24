require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# single node
# node = Nem::Node.new(host: '104.128.226.60')

# multiple nodes
node = Nem::NodePool.new([
  Nem::Node.new(host: 'bigalice2.nem.ninja'),
  Nem::Node.new(host: '192.3.61.243'),
  Nem::Node.new(host: '104.128.226.60')
])

# new Account Endpoint Object
account_endpoint = Nem::Endpoint::Account.new(node)

# find by address
pp account_endpoint.find('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# find by public key
pp account_endpoint.find_by_public_key('e59ef184a612d4c3c4d89b5950eb57262c69862b2f96e59c5043bf41765c482f')

# find forwarded by address
pp account_endpoint.find_forwarded('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# find forwarded by public key
pp account_endpoint.find_forwarded_by_public_key('e59ef184a612d4c3c4d89b5950eb57262c69862b2f96e59c5043bf41765c482f')

# fetch harvests
pp account_endpoint.harvests('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# namespace
pp account_endpoint.namespace('TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR')

# fetch mosaic definition of account
pp account_endpoint.mosaic_definition('TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR')

# fetch owned mosaics of account
pp account_endpoint.mosaic_owned('TDPICOQ7GIEMIDJOOMIQSOYIJKG3C7V7OP2DUFIR')

# transfers

## incomings
pp account_endpoint.transfers_incoming('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

## outgoings
pp account_endpoint.transfers_outgoing('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

## all
pp account_endpoint.transfers_all('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

## unconfirmed
pp account_endpoint.transfers_unconfirmed('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')

# status
# pp account_endpoint.status('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
pp account_endpoint.status('TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64')
pp account_endpoint.status('TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB')

# fetch importances
pp account_endpoint.importances

# unlock info
pp account_endpoint.unlocked_info

# historical data
pp account_endpoint.historical('TDWWYDGQNBKSAJBSHZX7QWVX7WNVAWWB7HGPWRB2',
  start_height: 1245390,
  end_height: 1245400,
  increment: 1
)
