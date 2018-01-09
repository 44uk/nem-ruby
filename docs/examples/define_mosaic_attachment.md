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
