module Nem
  module Model
    class Account
      include Nem::Mixin::Assignable

      attr_reader :address,
        :balance,
        :vested_balance,
        :importance,
        :public_key,
        :label,
        :harvested_blocks,
        :multisig_info,
        :cosignatory_of,
        :cosignatories,
        :status,
        :remote_status

      def self.new_from_account_meta_data_pair(hash)
        account = hash[:account]
        meta = hash[:meta]
        cosignatory_of = meta[:cosignatoryOf].map do |a|
          Account.new_from_account_data(a)
        end
        cosignatories = meta[:cosignatories].map do |a|
          Account.new_from_account_data(a)
        end
        new(
          address: account[:address],
          balance: account[:balance],
          vested_balance: account[:vestedBalance],
          importance: account[:importance],
          public_key: account[:publicKey],
          label: account[:label],
          harvested_blocks: account[:harvestedBlocks],
          cosignatory_of: cosignatory_of,
          cosignatories: cosignatories,
          status: meta[:status],
          remote_status: meta[:remoteStatus]
        )
      end

      def self.new_from_account_meta_data(hash)
        cosignatory_of = hash[:cosignatoryOf].map do |account|
          Account.new_from_account_data(account)
        end
        cosignatories = hash[:cosignatories].map do |account|
          Account.new_from_account_data(account)
        end
        new(
          cosignatory_of: cosignatory_of,
          cosignatories: cosignatories,
          status: hash[:status],
          remote_status: hash[:remoteStatus]
        )
      end

      def self.new_from_account_data(hash)
        multisig_info = MultisigInfo.new_from_multisig_info(hash[:multisigInfo])
        new(
          address: hash[:address],
          balance: hash[:balance],
          vested_balance: hash[:vestedBalance],
          importance: hash[:importance],
          public_key: hash[:publicKey],
          label: hash[:label],
          harvested_blocks: hash[:harvestedBlocks],
          multisig_info: multisig_info
        )
      end
    end
  end
end
