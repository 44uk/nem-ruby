module Nem
  module Endpoint
    class Chain < Nem::Endpoint::Base
      # @return [Nem::Model::Block]
      def last_block
        Nem::Model::Block.new_from_block request!(:get, '/chain/last-block')
      end

      # @return [Numeric]
      def height
        request!(:get, '/chain/height')[:height]
      end

      # @return [String]
      def score
        request!(:get, '/chain/score')[:score]
      end
    end
  end
end
