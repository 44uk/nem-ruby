# nem-ruby

[![Build Status](https://travis-ci.org/44uk/nem-ruby.svg?branch=master)](https://travis-ci.org/44uk/nem-ruby)
[![Gem Version](https://badge.fury.io/rb/nem-ruby.svg)](https://badge.fury.io/rb/nem-ruby)
[![Code Climate](https://codeclimate.com/github/44uk/nem-ruby/badges/gpa.svg)](https://codeclimate.com/github/44uk/nem-ruby)
[![Join the chat at https://gitter.im/44uk/nem-ruby](https://badges.gitter.im/44uk/nem-ruby.svg)](https://gitter.im/44uk/nem-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<img src="https://cloud.githubusercontent.com/assets/370508/24320282/a332d238-1175-11e7-96dc-75bc30e562d2.png" width="280" height="280" alt="nem" align="right" />

Ruby gem for communicating with the nem.

*The gem is under development. Incompatible changes can be made.*

*Not recommended for production use because of lack of testing, needed more improvement.*

For further development of nem with ruby, [feel free to send me your feedback!](#feedback-and-contact)

* [NEM \- Distributed Ledger Technology \(Blockchain\)](https://www.nem.io/)
* [NEM NIS API Documentation](https://nemproject.github.io/)
* [NEM Forum](https://forum.nem.io/)
* [NEM Testnet Faucet \- You can get Testnet XEM for development / testing.](http://test-nem-faucet.44uk.net/)

## Installation

```bash
$ gem install nem-ruby
```

Or add this line to your application's Gemfile:

```ruby
gem 'nem-ruby'
```

## Usage

```ruby
require 'pp'
require 'nem'

node = Nem::Node.new(host: '104.128.226.60')
account_endpoint = Nem::Endpoint::Account.new(node)

pp account_endpoint.find('TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4')
# => #<Nem::Model::Account:0x007fe95b35f560
#  @address="TBULEAUG2CZQISUR442HWA6UAKGWIXHDABJVIPS4",
#  @balance=68000000,
#  @cosignatories=[],
#  @cosignatory_of=[],
#  @harvested_blocks=1,
#  @importance=0.0,
#  @label=nil,
#  @public_key=
#   "e59ef184a612d4c3c4d89b5950eb57262c69862b2f96e59c5043bf41765c482f",
#  @remote_status="INACTIVE",
#  @status="LOCKED",
#  @vested_balance=62145647>
```

### Examples

More specific example codes are in **[examples/](examples/)** directory.

## Feedback and Contact

For further development of nem with ruby, feel free to send me your feedback!

* [@44uk_i3 - Twitter](https://twitter.com/44uk_i3)
* [44uk/nem-ruby - gitter](https://gitter.im/44uk/nem-ruby)

## For More Information

* [Documentation for nem-ruby - rubydoc.info](http://www.rubydoc.info/gems/nem-ruby)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/44uk/nem-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
