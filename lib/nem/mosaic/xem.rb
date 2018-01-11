module Nem
  module Mosaic
    class Xem
      include Nem::Mixin::MosaicAttachable
      namespace_id 'nem'
      name 'xem'
      divisibility 6
      initial_supply 8_999_999_999
    end
  end
end
