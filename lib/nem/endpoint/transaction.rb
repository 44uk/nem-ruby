module Nem
  module Endpoint
    class Transaction < Nem::Endpoint::Base
      # @param [String] hash
      # @return [Nem::Model::Transaction]
      def find(hash)
        request!(:get,
          '/transaction/get',
          hash: hash
        ) do |res|
          Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(res)
        end
      end

      alias get find

      # @return [Nem::Model::NemAnnounceResult]
      def announce(req)
        request!(:post,
          '/transaction/announce',
          req.respond_to?(:to_entity) ? req.to_entity : req.to_hash
        ) do |res|
          Nem::Model::NemAnnounceResult.new_from_nem_announce_result(res)
        end
      end

      # @return [Nem::Model::NemAnnounceResult]
      def prepare_announce(req)
        request!(:post,
          '/transaction/prepare-announce',
          req.to_entity(:prepare)
        ) do |res|
          Nem::Model::NemAnnounceResult.new_from_nem_announce_result(res)
        end
      end
    end
  end
end
