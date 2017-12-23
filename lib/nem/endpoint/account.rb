module Nem
  module Endpoint
    class Account < Nem::Endpoint::Base
      # @return [Nem::Model::Keypair]
      # @see https://nemproject.github.io/#generating-new-account-data
      def generate
        request!(:get, '/account/generate') do |res|
          Nem::Model::Keypair.new_from_key_pair_view_model(res)
        end
      end

      # @param [String] address
      # @return [Nem::Model::Account]
      # @see https://nemproject.github.io/#requesting-the-account-data
      def find(address)
        request!(:get, '/account/get',
          address: address
        ) do |res|
          Nem::Model::Account.new_from_account_meta_data_pair(res)
        end
      end

      alias get find

      # @param [String] public_key
      # @return [Nem::Model::Account]
      # @see https://nemproject.github.io/#requesting-the-account-data
      def find_by_public_key(public_key)
        request!(:get, '/account/get/from-public-key',
          publicKey: public_key
        ) do |res|
          Nem::Model::Account.new_from_account_meta_data_pair(res)
        end
      end

      # @param [String] address
      # @return [Nem::Model::Account]
      # @see https://nemproject.github.io/#requesting-the-original-account-data-for-a-delegate-account
      def find_forwarded(address)
        request!(:get, '/account/get/forwarded',
          address: address
        ) do |res|
          Nem::Model::Account.new_from_account_meta_data_pair(res)
        end
      end

      # @param [String] public_key
      # @return [Nem::Model::Account]
      # @see https://nemproject.github.io/#requesting-the-original-account-data-for-a-delegate-account
      def find_forwarded_by_public_key(public_key)
        request!(:get, '/account/get/forwarded/from-public-key',
          publicKey: public_key
        ) do |res|
          Nem::Model::Account.new_from_account_meta_data_pair(res)
        end
      end

      # @param [String] address
      # @param [String] hash
      # @return [Array <Nem::Model::Harvest>]
      # @see https://nemproject.github.io/#requesting-harvest-info-data-for-an-account
      def harvests(address, hash: nil)
        request!(:get, '/account/harvests',
          address: address,
          hash: hash
        ) do |res|
          res[:data].map do |harvest|
            Nem::Model::Harvest.new_from_harvest(harvest)
          end
        end
      end

      # @return [Array <Nem::Model::Importance>]
      # @see https://nemproject.github.io/#retrieving-account-importances-for-accounts
      def importances
        request!(:get, '/account/importances') do |res|
          res[:data].map do |aivm|
            Nem::Model::Importance.new_from_account_importance_view_model(aivm)
          end
        end
      end

      # @param [String] address
      # @param [Integer] start_height
      # @param [Integer] end_height
      # @param [Integer] increment
      # @return [Array <Nem::Model::AccountHistorical>]
      # @see https://nemproject.github.io/#retrieving-historical-account-data
      def historical(address, start_height: nil, end_height: nil, increment: nil)
        request!(:get, '/account/historical/get',
          address: address,
          startHeight: start_height,
          endHeight: end_height,
          increment: increment
        ) do |res|
          res[:data].map do |ah|
            Nem::Model::AccountHistorical.new_from_account_historical(ah)
          end
        end
      end

      # @param [String] address
      # @param [String] parent
      # @param [String] id
      # @return [Array <Nem::Model::MosaicDefinition>]
      # @see https://nemproject.github.io/##retrieving-mosaic-definitions-that-an-account-has-created
      def mosaic_definition(address, parent: nil, id: nil)
        request!(:get, '/account/mosaic/definition/page',
          address: address,
          parent: parent,
          id: id,
        ) do |res|
          res[:data].map do |modef|
            Nem::Model::MosaicDefinition.new_from_mosaic_definition(modef)
          end
        end
      end

      # @param [String] address
      # @return [Array <Nem::Model::AccountMetaDataPair>]
      # @see https://nemproject.github.io/#retrieving-mosaics-that-an-account-owns
      def mosaic_owned(address)
        request!(:get, '/account/mosaic/owned', address: address) do |res|
          res[:data].map do |moa|
            Nem::Model::Mosaic.new_from_mosaic(moa)
          end
        end
      end

      # @param [String] address
      # @param [String] parent
      # @param [String] id
      # @param [Integer] page_size
      # @return [Array <Nem::Model::Namespace>]
      # @see https://nemproject.github.io/#retrieving-namespaces-that-an-account-owns
      def namespace(address, parent: nil)
        request!(:get, '/account/namespace/page', address: address, parent: parent) do |res|
          res[:data].map do |ns|
            Nem::Model::Namespace.new_from_namespace(ns)
          end
        end
      end

      # @param [String] address
      # @return [Nem::Model::Account]
      # @see https://nemproject.github.io/#requesting-the-account-status
      def status(address)
        request!(:get, '/account/status', address: address) do |res|
          Nem::Model::Account.new_from_account_meta_data(res)
        end
      end

      # @param private_key [String]
      # @return [nil]
      # @see https://nemproject.github.io/#locking-and-unlocking-accounts
      def lock(private_key)
        request!(:post, '/account/lock', value: private_key)
      end

      # @param [String] private_key
      # @return [nil]
      # @see https://nemproject.github.io/#locking-and-unlocking-accounts
      def unlock(private_key)
        request!(:post, '/account/unlock', value: private_key)
      end

      # @return [Nem::Model::UnlockedInfo]
      # @see https://nemproject.github.io/#retrieving-the-unlock-info
      def unlocked_info
        request!(:post, '/account/unlocked/info') do |res|
          Nem::Model::UnlockedInfo.new_from_unlocked_info(res)
        end
      end

      # @param [String] address
      # @param [String] hash
      # @param [String] id
      # @param [Integer] page_size
      # @return [Array <Nem::Model::Transaction>]
      # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
      def transfers_incoming(address, hash: nil, id: nil, page_size: nil)
        request!(:get, '/account/transfers/incoming',
          address: address,
          hash: hash,
          id: id,
          pageSize: page_size
        ) do |res|
          res[:data].map do |tx|
            Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
          end
        end
      end

      # @param [String] address
      # @param [String] hash
      # @param [String] id
      # @param [Integer] page_size
      # @return [Array <Nem::Model::Transaction>]
      # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
      def transfers_outgoing(address, hash: nil, id: nil, page_size: nil)
        request!(:get, '/account/transfers/outgoing',
          address: address,
          hash: hash,
          id: id,
          pageSize: page_size
        ) do |res|
          res[:data].map do |tx|
            Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
          end
        end
      end

      # @param [String] address
      # @param [String] hash
      # @param [String] id
      # @param [Integer] page_size
      # @return [Array <Nem::Model::Transaction>]
      # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
      def transfers_all(address, hash: nil, id: nil, page_size: nil)
        request!(:get, '/account/transfers/all',
          address: address,
          hash: hash,
          id: id,
          pageSize: page_size
        ) do |res|
          res[:data].map do |tx|
            Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
          end
        end
      end

      # @param [String] address
      # @return [Array <Nem::Model::Transaction>]
      # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
      def unconfirmed_transactions(address)
        request!(:get, '/account/unconfirmedTransactions',
          address: address
        ) do |res|
          res[:data].map do |tx|
            Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
          end
        end
      end

      alias transfers_unconfirmed unconfirmed_transactions

      # @param [String] address
      # @param [String] hash
      # @param [String] id
      # @param [Symbol] dir direction(:in, :out, :unconfirmed, :all)
      # @param [Integer] page_size
      # @return [Array <Nem::Model::TransactionMetaDataPair>]
      # @see https://nemproject.github.io/#requesting-transaction-data-for-an-account
      def transfers(address, hash: nil, id: nil, page_size: nil, dir: :all)
        case dir.to_s
        when /\Ain/  then transfers_incoming(address, hash, id, page_size)
        when /\Aout/ then transfers_outgoing(address, hash, id, page_size)
        when /\Aunconfirmed/ then transfers_unconfirmed(address)
        else transfers_all(address, hash, id, page_size)
        end
      end
    end
  end
end
