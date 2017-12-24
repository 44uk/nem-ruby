require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# single node
# node = Nem::Node.new(host: '104.128.226.60')

# --- allow only local node
account_endpoint = Nem::Endpoint::Account.new(Nem::Node.new)

## lock account
# privateKey for TARUBYIMKHJF2HMPVVHSJNMKKS7DCBSOH45QKBW2
pp account_endpoint.lock('6733898f911bb96f69eab04adf9def4d146add9a5cb16ac0fbe66fba064f126a')

## unlock account
# privateKey for TARUBYIMKHJF2HMPVVHSJNMKKS7DCBSOH45QKBW2
pp account_endpoint.unlock('6733898f911bb96f69eab04adf9def4d146add9a5cb16ac0fbe66fba064f126a')

## generate account
pp account_endpoint.generate
