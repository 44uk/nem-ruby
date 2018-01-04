## Introduction

[![Gem Version](https://badge.fury.io/rb/nem-ruby.svg)](https://badge.fury.io/rb/nem-ruby)
[![Build Status](https://travis-ci.org/44uk/nem-ruby.svg?branch=master)](https://travis-ci.org/44uk/nem-ruby)
[![Code Climate](https://codeclimate.com/github/44uk/nem-ruby/badges/gpa.svg)](https://codeclimate.com/github/44uk/nem-ruby)
[![Join the chat at https://gitter.im/44uk/nem-ruby](https://badges.gitter.im/44uk/nem-ruby.svg)](https://gitter.im/44uk/nem-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<img src="https://cloud.githubusercontent.com/assets/370508/24320282/a332d238-1175-11e7-96dc-75bc30e562d2.png" width="280" height="280" alt="nem" align="right" />

Ruby gem for communicating with the nem.

For further development of nem with ruby, [feel free to send me your feedback!](/about#feedback-and-contact)

## Installation

```bash
$ gem install nem-ruby
```

or add this line to your application's Gemfile.

```ruby
gem 'nem-ruby'
```

## Connection

```ruby
require 'pp'
require 'nem'

# connect to remote node
node = Nem::Node.new(host: 'bigalice2.nem.ninja')

# ENV['NEM_URL'] can be used if it set.
# export NEM_URL=http://bigalice2.nem.ninja:7890
node = Nem::Node.new

# connect to local node if no params
node = Nem::Node.new

# passing options
node = Nem::Node.new(host: '127.0.0.1', port: 7890)

# passing url
node = Nem::Node.new(url: 'http://127.0.0.1:7890')
```

You can pick node from [NEM Node Rewards](https://supernodes.nem.io/).

### Node Pool

```ruby
# create node pool
node = Nem::NodePool.new([
  Nem::Node.new(host: 'dummy1.example.com'),
  Nem::Node.new(host: 'dummy2.example.com'),
  Nem::Node.new(host: 'bigalice2.nem.ninja')
])
```

## Endpoint

```ruby
endpoint = Nem::Endpoint::Account.new(node)
pp endpoint.find('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
# <Nem::Model::Account:0x007fca1b101070
#   @address="TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4",
#   @balance=68000000,
#   @cosignatories=[],
#   @cosignatory_of=[],
#   @harvested_blocks=1,
#   @importance=0.0,
#   @label=nil,
#   @public_key="e59ef184a612d4c3c4d89b5950eb57262c69862b2f96e59c5043bf41765c482f",
#   @remote_status="INACTIVE",
#   @status="LOCKED",
#   @vested_balance=62145647
# >
```

## Node

```ruby
node.heartbeat
# <Nem::Model::Heartbeat:0x007f83d3b6eb68 @code=1, @message="ok", @type=2>
# See https://nemproject.github.io/#heart-beat-request

node.status
# <Nem::Model::Status:0x007f83d3b54920 @code=6, @message="status", @type=4>
# See https://nemproject.github.io/#status-request
```

### calling API Path

Also call Nem::Node#request method. The method receive *HTTP Method*, *API Path*, *Parameters*
It returns hash which converted API JSON response. by API path /heartbeat, /status

See [NEM NIS API Documentation](https://nemproject.github.io/).

```ruby
pp node.request :get, 'heartbeat'

pp node.request :get, 'status'

pp node.request :get, 'account/get', address: 'TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4'

pp node.request :post, 'account/unlock', privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
```

## Logging

```ruby
# custom loggin output (default is STDOUT)
Nem.logger = Logger.new('/path/to/nem-ruby.log')
# turn on output request information.
Nem.logger.level = Logger::DEBUG

# also set condig this way.
Nem.configure do |conf|
  conf.logger = Logger.new('./nem-ruby.log')
  conf.logger.level = Logger::DEBUG

  # you can set deadline(sec)
  conf.default_deadline = 7200

  # set :mainnet if you'd like to use on mainnet(default :testnet)
  conf.default_network = :mainnet
end
```

### Output

```
D, [2017-09-26T08:03:54.752718 #78207] DEBUG -- : host:http://127.0.0.1:7890/   method:post     path:/transaction/prepare-announce      params:{:transaction=>{:type=>257, :network=>:testnet, :recipient=>"TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF", :amount=>1000000, :message=>{:payload=>"476f6f64206c75636b21", :type=>1}, :fee=>100000, :timeStamp=>78793049, :deadline=>78796649, :version=>2550136833, :signer=>"be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033"}, :privateKey=>"4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214"}
```

## Examples

More specific example codes are in **[examples/](https://github.com/44uk/nem-ruby/tree/master/examples)** directory.

## XEM for development

You can get Testnet XEM for development / testing from these faucet or thread.

* [NEM Testnet Faucet \- You can get Testnet XEM for development / testing.](http://test-nem-faucet.44uk.net/)
* [NEM TESTNET faucet〜てすとねっと蛇口〜](http://tomotomo9696.xyz/nem/faucet/)
* [NEM testnet Faucet](http://namuyan.dip.jp/nem/testnet/)
* [Paste you address here for beta NEM (Testnet XEM) - Technical Discussion - NEM Forum](https://forum.nem.io/t/paste-you-address-here-for-beta-nem-testnet-xem/829)

## Rubydoc

* [Documentation for nem-ruby - rubydoc.info](http://www.rubydoc.info/gems/nem-ruby)
