module Nem
  module Mosaic
    class EcobitEco
      include Nem::Mixin::MosaicAttachable
      namespace_id 'ecobit'
      name 'eco'
      divisibility 0
      initial_supply 888_888_888
    end
  end
end
