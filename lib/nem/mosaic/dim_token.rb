module Nem
  module Mosaic
    class DimToken
      include Nem::Mixin::MosaicAttachable
      namespace_id 'dim'
      name 'token'
      divisibility 6
      initial_supply 1_000_000
    end
  end
end
