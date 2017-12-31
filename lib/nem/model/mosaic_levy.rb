module Nem
  module Model
    class MosaicLevy
      include Nem::Mixin::Assignable

      attr_reader :fee,
        :recipient,
        :type,
        :mosaic_id

      def self.new_from_mosaic_levy(hash)
        return nil if hash.empty?
        mosaic_id = MosaicId.new_from_mosaic_id(hash[:mosaicId])
        new(
          fee: hash[:fee],
          recipient: hash[:recipient],
          type: hash[:type],
          mosaic_id: mosaic_id
        )
      end

      def to_hash
        {
          fee: fee,
          recipient: recipient,
          type: type,
          mosaicId: mosaic_id.to_hash
        }
      end
    end
  end
end
