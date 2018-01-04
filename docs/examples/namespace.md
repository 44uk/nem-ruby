## Endpoint

```ruby
node = Nem::Node.new(host: 'bigalice2.nem.ninja')
endpoint = Nem::Endpoint::Namespace.new(node)
```

## find

```ruby
pp ns_endpoint.find('alice')
```


## root

```ruby
pp ns_endpoint.root(882, page_size: 1)
```

## mosaic definition page

```ruby
pp ns_endpoint.mosaic_definition('tpico')
```
