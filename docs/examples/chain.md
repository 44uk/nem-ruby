## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Chain.new(node)
```

## height

```ruby
pp endpoint.height
```

## score

```ruby
pp endpoint.score
```

## last block

```ruby
pp endpoint.last_block
```
