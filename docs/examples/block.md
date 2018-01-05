## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Account.new(node)
```

## at public

```ruby
pp endpoint.at_public(1_223_559)
```
