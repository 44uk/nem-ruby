module Nem
  module Mosaic
    class QchainXqc
      include Nem::Mixin::MosaicAttachable
      namespace_id 'qchain'
      name 'xqc'
      divisibility 6
      initial_supply 375000000
    end
  end
end
