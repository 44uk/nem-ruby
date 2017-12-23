module Nem
  module Endpoint
    class Block < Nem::Endpoint::Base
      def find(hash)
        Nem::Model::Block.new_from_block request!(:get, '/block/get', blockHash: hash)
      end

      alias get find

      def at_public(height)
        Nem::Model::Block.new_from_block request!(:post, '/block/at/public', height: height)
      end
    end
  end
end
