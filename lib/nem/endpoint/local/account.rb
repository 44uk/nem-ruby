module Nem
  module Endpoint
    module Local
      class Account < Nem::Endpoint::Base
        # @see https://nemproject.github.io/#transaction-data-with-decoded-messages
        def transfers_incoming(value, hash: nil, id: nil, page_size: nil)
          request!(:post, '/local/account/transfers/incoming',
            value: value,
            hash: hash,
            id: id,
            pageSize: page_size
          ) do |res|
            res[:data].map do |tx|
              Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
            end
          end
        end

        # @see https://nemproject.github.io/#transaction-data-with-decoded-messages
        def transfers_outgoing(value, hash: nil, id: nil, page_size: nil)
          request!(:post, '/local/account/transfers/outgoing',
            value: value,
            hash: hash,
            id: id,
            pageSize: page_size
          ) do |res|
            res[:data].map do |tx|
              Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
            end
          end
        end

        # @see https://nemproject.github.io/#transaction-data-with-decoded-messages
        def transfers_all(value, hash: nil, id: nil, page_size: nil)
          request!(:post, '/local/account/transfers/all',
            value: value,
            hash: hash,
            id: id,
            pageSize: page_size
          ) do |res|
            res[:data].map do |tx|
              Nem::Model::Transaction.new_from_account_transaction_meta_data_pair(tx)
            end
          end
        end

        def transfers(value, hash: nil, id: nil, page_size: nil, dir: :all)
          case dir.to_s
          when /\Ain/  then transfers_incoming(value, hash: hash, id: id, page_size: page_size)
          when /\Aout/ then transfers_outgoing(value, hash: hash, id: id, page_size: page_size)
          else transfers_all(value, hash: hash, id: id, page_size: page_size)
          end
        end
      end
    end
  end
end
