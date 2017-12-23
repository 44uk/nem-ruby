## Endpoint

```ruby
node = Nem::Node.new
endpoint = Nem::Endpoint::Local.new(node)
```

## account transfers

```ruby
value = '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'

# mapped methods
pp endpoint.transfers_incoming(value)
pp endpoint.transfers_outgoing(value)
pp endpoint.transfers_all(value)

# another way
pp endpoint.transfers(value, :in)
pp endpoint.transfers(value, :out)
pp endpoint.transfers(value, :all)
```

##chain blocks after

```ruby
pp endpoint.blocks_after(1_223_559)
```
