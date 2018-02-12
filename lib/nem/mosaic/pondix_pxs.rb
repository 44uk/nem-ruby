module Nem
  module Mosaic
    class PondixPxs
      include Nem::Mixin::MosaicAttachable
      namespace_id 'pondix'
      name 'pxs'
      divisibility 6
      initial_supply 5000000
    end
  end
end
