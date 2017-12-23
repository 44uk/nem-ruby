module Nem
  module Model
    class MosaicOwned
      include Nem::Mixin::Assignable

      attr_reader :mosaics

      def self.new_from_mosaic_owned(hash)
        mosaics = hash[:data].inject({}) do |memo, mos|
          mosaic = Nem::Model::Mosaic.new_from_mosaic(mos)
          memo[mosaic.fqn] = mosaic
          memo
        end
        new(mosaics: mosaics)
      end

      def find(fqn)
        mosaics[fqn]
      end
    end
  end
end
