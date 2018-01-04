## Configuration

```ruby
Nem.configure do |conf|
  # output path
  conf.logger = Logger.new('./nem-ruby.log')

  # logger level
  conf.logger.level = Logger::DEBUG

  # output debug log
  conf.debug = true

  # deadline(sec)
  conf.default_deadline = 7200

  # :mainnet if you'd like to use on mainnet!
  conf.default_network = :mainnet
end
```
