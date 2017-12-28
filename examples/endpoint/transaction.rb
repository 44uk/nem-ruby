require 'pp'
require 'nem'

node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# new Account Endpoint Object
tx_endpoint = Nem::Endpoint::Transaction.new(node)

# find transfer by hash
pp tx_endpoint.find('a7131c0836da45e72f61ac6e76259d7200a85f0d2cf38f79f223b2c366673b08')

# important transfer
hash = '0765dbe0e79c2a57f2f71ae77f915d67b66290b2f72db5b3537bb32a1b09e2bf'
pp tx_endpoint.find(hash)

# multisig aggregate modification
hash = '9593e7846c01a3a8c00363af9ae7a333cc11e266eb88636957578ae0d9f495a3'
pp tx_endpoint.find(hash)

# multisig signature
# hash = ''
# tx_endpoint.find(hash)

# transfer (multisig)
hash = '4185cad053f0bc7a2b3b9e5adc493e81a5af2f0a431f3d34ba2a25c937731629'
pp tx_endpoint.find(hash)

# aggregate (multisig)
hash = 'f7d385a4c8b78d8a6a91c7b778df4ae793394c9c8bfeeca1393bf43770328a06'
pp tx_endpoint.find(hash)

# provision namespace
hash = '63a3982228b68de56c73896d394cfa3698d7d81e7aec89ea1a77a6d68d103d22'
pp tx_endpoint.find(hash)

# mosaic definition creation
hash = '0a16d30f57d65c5241cb0894a50fee51efbf6ff25a7a605de10423819234ab5d'
pp tx_endpoint.find(hash)

# mosaic supply change
hash = '7d2c7f4c2895075a4c1bf2fdceba3781c3a80313e6979c29f1cd83277fe64ded'
pp tx_endpoint.find(hash)
