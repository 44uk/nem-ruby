module Nem
  module Endpoint
    class Chain < Nem::Endpoint::Base
      def last_block
        Nem::Model::Block.new_from_block request!(:get, '/chain/last-block')
      end

      def height
        request!(:get, '/chain/height')[:height]
      end

      def score
        request!(:get, '/chain/score')[:score]
      end
    end
  end
end
