## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Timesync.new(node)
```

## Network time

```ruby
pp endpoint.network_time
```
