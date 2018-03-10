module Nem
  module Util
    module Deserializer
      # Deserialize a transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize(serialized)
        s = Nem::Util::Convert.hex2ua(serialized)
        deserialize_transaction(s)
      end

      private

      def self.switch_method(type)
        case type
        when 0x0101 then method(:deserialize_transfer)
        when 0x0801 then method(:deserialize_importance_transfer)
        when 0x1001 then method(:deserialize_multisig_aggregate_modification)
        when 0x1002 then method(:deserialize_multisig_signature)
        when 0x1004 then method(:deserialize_multisig)
        when 0x2001 then method(:deserialize_provision_namespace)
        when 0x4001 then method(:deserialize_mosaic_definition_creation)
        when 0x4002 then method(:deserialize_mosaic_supply_change)
          else raise "Not implemented entity type: #{type}"
        end
      end

      # Deserialize a transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_transaction(s)
        common = s[0, 60]
        specific = s[60, s.size]
        type = deserialize_int(common[0, 4])
        method = switch_method(type)
        # require 'pry'; binding.pry
        deserialize_common(common).merge(method.call(specific))
      end

      # Deserialize a transfer transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_transfer(s)
        tx = {}
        tx[:recipient] = deserialize_a(s[4, 40])
        tx[:amount] = deserialize_int(s[44, 8])
        tx[:message] = {}
        msg_len = deserialize_int(s[52, 4])
        if msg_len > 0
          payload_len = deserialize_int(s[60, 4])
          tx[:message] = {
            type: deserialize_int(s[56, 4]),
            payload: Nem::Util::Convert.hex_to_utf8(deserialize_hex(s[64, payload_len]))
          }
        else
          tx[:message] = { type: 1, payload: '' }
        end

        mosaic_cnt = deserialize_int(s[56 + msg_len, 4])
        return tx unless mosaic_cnt

        # mosaic section
        tx[:mosaics] = []
        offset = 0
        mosaic_cnt.times do |i|
          mo_len = deserialize_int(s[offset + 60 + msg_len, 4])
          # ns_len = deserialize_int(s[offset+64+msg_len, 4])
          ns_name_len = deserialize_int(s[offset + 68 + msg_len, 4])
          mo_name_len = deserialize_int(s[offset + 72 + msg_len + ns_name_len, 4])
          ns = Nem::Util::Convert.hex_to_utf8 deserialize_hex(s[offset + 72 + msg_len, ns_name_len])
          name = Nem::Util::Convert.hex_to_utf8 deserialize_hex(s[offset + 76 + msg_len + ns_name_len, mo_name_len])
          quantity = deserialize_int(s[offset + 76 + msg_len + ns_name_len + mo_name_len, 8])
          attachment = {
            mosaicId: { namespaceId: ns, name: name },
            quantity: quantity
          }
          tx[:mosaics] << attachment
          offset += mo_len + 4
        end
        tx
      end

      # Deserialize a importance transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_importance_transfer(s)
        {
          mode: deserialize_int(s[0, 4]),
          remoteAccount: deserialize_hex(s[8, 32])
        }
      end

      # Deserialize a multisig aggregate modification transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_multisig_aggregate_modification(s)
        mods = []
        mod_count = deserialize_int(s[0, 4])
        offset = 4
        mod_count.times do |i|
          mod_len = deserialize_int(s[offset, 4])
          mods << {
            modificationType: deserialize_int(s[offset + 4, 4]),
            cosignatoryAccount: deserialize_hex(s[offset + 12, 32])
          }
          offset += 4 + mod_len
        end
        tx = {
          modifications: mods,
        }

        if s[offset + 4, 4]
          tx.merge(
            minCosignatories: {
              relativeChange: deserialize_int(s[offset + 4, 4])
            }
          )
        else
          tx
        end
      end

      # Deserialize a multisig signature transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_multisig_signature(s)
        {
          otherHash: { data: deserialize_hex(s[8, 32]) },
          otherAccount: deserialize_a(s[44, 40])
        }
      end

      # Deserialize a multisig transfer transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_multisig(s)
        msig_len = deserialize_int(s[0, 4])
        inner = s[4, msig_len]
        inner_tx = deserialize_transaction(inner)
        { otherTrans: inner_tx }
      end

      # Deserialize a provision namespace transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_provision_namespace(s)
        tx = {}
        tx[:rentalFeeSink] = deserialize_a(s[4, 40])
        tx[:rentalFee] = deserialize_int(s[44, 8])
        newpart_len = deserialize_int(s[52, 4])
        tx[:newPart] = deserialize_a(s[56, newpart_len])
        parent_len = deserialize_int(s[56 + newpart_len, 4])
        parent = s[56 + newpart_len, parent_len]
        unless parent.all? { |val| val == 0xff }
          tx[:parent] = deserialize_a(parent)
        end
        tx
      end

      # Deserialize a mosaic definition creation transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_mosaic_definition_creation(s)
        raise 'Not yet implimented.'
        # TODO: deserializing
        tx = {}
        tx
      end

      # Deserialize a mosaic supply change transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize_mosaic_supply_change(s)
        tx = {}
        # s[0, 4] # Length of mosaic id structure
        ns_len = deserialize_int(s[4, 4])
        mo_len = deserialize_int(s[8 + ns_len, 4])
        tx[:mosaicId] = {
          namespaceId: deserialize_a(s[8, ns_len]),
          name: deserialize_a(s[8 + ns_len + mo_len, mo_len])
        }
        tx[:supplyType] = deserialize_int(s[8 + ns_len + 4 + mo_len, 4])
        tx[:delta] = deserialize_int(s[8 + ns_len + 4 + mo_len + 4, 8])
        tx
      end

      def self.deserialize_common(s)
        {
          type: deserialize_int(s[0, 4]),
          version: deserialize_int(s[4, 4]),
          timeStamp: deserialize_int(s[8, 4]),
          # s[12,4] # length of public key,
          signer: deserialize_hex(s[16, 32]),
          fee: deserialize_int(s[48, 8]),
          deadline: deserialize_int(s[56, 4])
        }
      end

      def self.deserialize_int(ua)
        Nem::Util::Convert.ua2hex(ua.reverse).to_i(16)
      end

      def self.deserialize_hex(ua)
        Nem::Util::Convert.ua2hex(ua)
      end

      def self.deserialize_a(ua)
        Nem::Util::Convert.hex2a(deserialize_hex(ua))
      end
    end
  end
end
