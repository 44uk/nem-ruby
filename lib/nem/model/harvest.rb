module Nem
  module Model
    class Harvest
      include Nem::Mixin::Assignable

      attr_reader :timestamp,
        :difficulty,
        :total_fee,
        :id,
        :height

      def self.new_from_harvest(hash)
        new(
          timestamp: hash[:timeStamp],
          difficulty: hash[:difficulty],
          total_fee: hash[:totalFee],
          id: hash[:id],
          height: hash[:height]
        )
      end
    end
  end
end
