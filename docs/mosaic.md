## Mosaic attachment definition

```ruby
class MyMosaic
  include Nem::Mixin::MosaicAttachable
  namespace_id 'my'
  name 'moz'
  divisibility 3
  initial_supply 1_234_567_890
end
```

## Build-in Mosaic definitions

```
Nem::Mosaic::ComsaCms
Nem::Mosaic::DimCoin
Nem::Mosaic::DimToken
Nem::Mosaic::EcobitEco
Nem::Mosaic::PondixPxs
Nem::Mosaic::QchainXqc
Nem::Mosaic::Xem
```
