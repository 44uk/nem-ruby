module Nem
  module Endpoint
    class Chain < Nem::Endpoint::Base
      # @return [Nem::Model::Block]
      # @see https://nemproject.github.io/#last-block-of-the-block-chain-score
      def last_block
        Nem::Model::Block.new_from_block request!(:get, '/chain/last-block')
      end

      # @return [Numeric]
      # @see https://nemproject.github.io/#block-chain-height
      def height
        request!(:get, '/chain/height')[:height]
      end

      # @return [String]
      # @see https://nemproject.github.io/#block-chain-score
      def score
        request!(:get, '/chain/score')[:score]
      end
    end
  end
end
