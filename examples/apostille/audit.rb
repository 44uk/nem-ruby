require 'pp'
require 'nem'

Nem.logger.level = Logger::DEBUG

FIXTURES_PATH = File.expand_path('../../../spec/fixtures', __FILE__)

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
