## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Debug.new(node)
```

## connections

```ruby
# mapped methods
pp endpoint.connections_incoming
pp endpoint.connections_outgoing
pp endpoint.connections_timers

# another way
pp endpoint.debug_connections(:in)
pp endpoint.debug_connections(:out)
```

## time synchronization

```ruby
pp endpoint.time_synchronization
```
