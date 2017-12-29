module Nem
  module Request
    # @attr [Nem::Struct::Transaction] transaction
    # @attr [Nem::Keypair] keypair
    # @attr [String] data
    # @attr [String] signature
    # @see https://nemproject.github.io/#requestAnnounce
    # @see https://nemproject.github.io/#requestPrepareAnnounce
    class Announce
      attr_reader :transaction, :keypair, :data, :signature

      def initialize(transaction, keypair)
        @transaction = transaction
        @keypair = keypair
      end

      # @return [Hash] Attribute and value pairs
      def to_entity(state = nil)
        entity = prepare_entity
        if Nem.debug
          Nem.logger.debug '%s' % [entity.inspect]
        end
        if state == :prepare
          { transaction: entity,
            privateKey: keypair.private }
        else
          serialized = serialize(entity)
          hex_serialized = Nem::Util::Convert.ua2hex(serialized)
          { data: Nem::Util::Convert.ua2hex(serialized),
            signature: signature(hex_serialized) }
        end
      end

      private

      def prepare_entity
        specify = if transaction.multisig?
          prepare_multisig(transaction)
        else
          transaction.to_hash
        end
        set_common(specify)
      end

      def prepare_multisig(tx)
        other_trans = tx.other_trans.to_hash.merge(
          type: tx.other_trans.type,
          fee: tx.other_trans.fee.to_i,
          timeStamp: Nem::Util.timestamp,
          deadline: Nem::Util.deadline(Nem.deadline),
          signer: tx.signer,
          version: tx.other_trans.version
        )
        tx.to_hash.merge(
          otherTrans: other_trans
        )
      end

      def set_common(hash)
        hash.merge(
          type: transaction.type,
          fee: transaction.fee.to_i,
          timeStamp: Nem::Util.timestamp,
          deadline: Nem::Util.deadline(Nem.deadline),
          signer: keypair.public,
          version: transaction.version
        )
      end

      def serialize(hash)
        Nem::Util::Serializer.serialize_transaction(hash)
      end

      def signature(serialized)
        keypair.sign(serialized)
      end
    end
  end
end
