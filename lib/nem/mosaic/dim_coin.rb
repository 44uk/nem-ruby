module Nem
  module Mosaic
    class DimCoin
      include Nem::Mixin::MosaicAttachable
      namespace_id 'dim'
      name 'coin'
      divisibility 6
      initial_supply 900_000_000
    end
  end
end
