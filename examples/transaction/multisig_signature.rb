require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

# multisig
M_PUBLIC_KEY = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'
M_ADDRESS = 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'

# cosignatory1
# A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'
# A_PUBLIC_KEY  = 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033'
# A_ADDRESS = 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB'

# cosignatory2
B_PRIVATE_KEY = '1d13af2c31ee6fb0c3c7aaaea818d9b305dcadba130ba663fc42d9f25b24ded1'
B_PUBLIC_KEY = '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933'
B_ADDRESS = 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF'

kp = Nem::Keypair.new(B_PRIVATE_KEY)
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
tx_endpoint = Nem::Endpoint::Transaction.new(node)
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
res = tx_endpoint.announce(req)

pp "Message: #{res.message}"
pp "TransactionHash: #{res.transaction_hash}"
