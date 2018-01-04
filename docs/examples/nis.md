## Node

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
```

## heartbeat

```ruby
pp node.heartbeat

# passing API Path
pp node.request :get, 'heartbeat'
```

## status

```ruby
pp node.status

# passing API Path
pp node.request :get, 'status'
```
