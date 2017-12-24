module Nem
  module Endpoint
    class Mosaic < Nem::Endpoint::Base
      # @return <Nem::Model::Namespace>
      # @see https://nemproject.github.io/#
      def supply(mosaic_id)
        request!(:get, '/mosaic/supply', mosaicId: mosaic_id) do |res|
          Nem::Model::MosaicSupply.new_from_mosaic_supply(res)
        end
      end
    end
  end
end
