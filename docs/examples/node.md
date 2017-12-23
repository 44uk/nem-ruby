## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Node.new(node)
```

## Info

```ruby
pp endpoint.node_info
pp endpoint.node_extended_info
pp endpoint.node_experiences
```

## Peerlist

```ruby
# mapped methods
pp endpoint.node_peerlist_all
pp endpoint.node_peerlist_reachable
pp endpoint.node_peerlist_active

# another way
pp endpoint.node_peerlist(:all)
pp endpoint.node_peerlist(:reachable)
pp endpoint.node_peerlist(:active)
```

## Active peers max chain height

```ruby
endpoint = node_endpoint = Nem::Endpoint::Node.new(Nem::Node.new)

pp endpoint.node_active_peers_max_chain_height
```

## Boot node request

```ruby
bnr = Nis::Struct::BootNodeRequest.new(
  metaData: {
    application: 'NIS'
  },
  endpoint: {
    protocol: 'http',
    port: 7890,
    host: 'localhost'
  },
  identity: {
    'private-key': 'a6cbd01d04edecfaef51df9486c111abb6299c764a00206eb1d01f4587491b3f',
    name: 'Alice'
  }
)

begin
  pp endpoint.node_boot(boot_node_request: bnr)
rescue => ex
  pp ex
end
```
