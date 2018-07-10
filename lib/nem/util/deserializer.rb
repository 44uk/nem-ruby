module Nem
  module Util
    module Deserializer
      # Deserialize a transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.deserialize(serialized)
        s = serialized.scan(/../)
        transaction(s)
      end

      private

      def self.transaction(s)
        comm = s[0, 60]
        spec = s[60, s.size]
        type = hexa2int(comm[0, 4])
        method = switch_method(type)
        common(comm).merge(method.call(spec))
      end

      def self.hexa2int(hexa)
        [hexa.join].pack('H*').unpack('i*').first
      end

      def self.hexa2ascii(hexa)
        hexa.inject('') { |memo, el| memo << el.hex.chr }
      end

      def self.hexa2utf8(hexa)
        [hexa.join].pack('H*').force_encoding('UTF-8')
      end

      def self.switch_method(type)
        case type
        when 0x0101 then method(:transfer)
        when 0x0801 then method(:importance_transfer)
        when 0x1001 then method(:multisig_aggregate_modification)
        when 0x1002 then method(:multisig_signature)
        when 0x1004 then method(:multisig)
        when 0x2001 then method(:provision_namespace)
        when 0x4001 then method(:mosaic_definition_creation)
        when 0x4002 then method(:mosaic_supply_change)
          else raise "Not implemented entity type: #{type}"
        end
      end

      # Deserialize transaction common part
      # @param [String] serialized
      # @return [Hash]
      def self.common(s)
        {
          type: hexa2int(s[0, 4]),
          version: hexa2int(s[4, 4]),
          timeStamp: hexa2int(s[8, 4]),
          signer: s[16, 32].join,
          fee: hexa2int(s[48, 8]),
          deadline: hexa2int(s[56, 4])
        }
      end

      # Deserialize a transfer transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.transfer(s)
        tx = {}
        tx[:recipient] = hexa2ascii(s[4, 40])
        tx[:amount] = hexa2int(s[44, 8])
        tx[:message] = {}
        msg_len = hexa2int(s[52, 4])
        if msg_len > 0
          payload_len = hexa2int(s[60, 4])
          tx[:message] = {
            type: hexa2int(s[56, 4]),
            payload: hexa2utf8(s[64, payload_len])
          }
        else
          tx[:message] = { type: 1, payload: '' }
        end

        mosaic_cnt = hexa2int(s[56 + msg_len, 4])
        return tx unless mosaic_cnt

        # mosaic section
        tx[:mosaics] = []
        offset = 0
        mosaic_cnt.times do |i|
          mo_len = hexa2int(s[offset + 60 + msg_len, 4])
          ns_name_len = hexa2int(s[offset + 68 + msg_len, 4])
          mo_name_len = hexa2int(s[offset + 72 + msg_len + ns_name_len, 4])
          ns = hex2ascii(s[offset + 72 + msg_len, ns_name_len])
          name = hex2ascii(s[offset + 76 + msg_len + ns_name_len, mo_name_len])
          quantity = hexa2int(s[offset + 76 + msg_len + ns_name_len + mo_name_len, 8])
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
      def self.importance_transfer(s)
        {
          mode: hexa2int(s[0, 4]),
          remoteAccount: s[8, 32].join
        }
      end

      # Deserialize a multisig aggregate modification transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.multisig_aggregate_modification(s)
        mods = []
        mod_count = hexa2int(s[0, 4])
        offset = 4
        mod_count.times do |i|
          mod_len = hexa2int(s[offset, 4])
          mods << {
            modificationType: hexa2int(s[offset + 4, 4]),
            cosignatoryAccount: s[offset + 12, 32].join
          }
          offset += 4 + mod_len
        end
        tx = {
          modifications: mods,
        }

        if s[offset + 4, 4]
          tx.merge(
            minCosignatories: {
              relativeChange: hexa2int(s[offset + 4, 4])
            }
          )
        else
          tx
        end
      end

      # Deserialize a multisig signature transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.multisig_signature(s)
        {
          otherHash: { data: s[8, 32].join },
          otherAccount: hexa2ascii(s[44, 40])
        }
      end

      # Deserialize a multisig transfer transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.multisig(s)
        msig_len = hexa2int(s[0, 4])
        inner = s[4, msig_len]
        inner_tx = transaction(inner)
        { otherTrans: inner_tx }
      end

      # Deserialize a provision namespace transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.provision_namespace(s)
        tx = {}
        tx[:rentalFeeSink] = hexa2ascii(s[4, 40])
        tx[:rentalFee] = hexa2int(s[44, 8])
        newpart_len = hexa2int(s[52, 4])
        tx[:newPart] = hexa2ascii(s[56, newpart_len])
        parent_len = hexa2int(s[56 + newpart_len, 4])
        unless parent_len == -1
          parent = s[56 + newpart_len, parent_len]
          tx[:parent] = hexa2ascii(parent)
        end
        tx
      end

      # Deserialize a mosaic definition creation transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.mosaic_definition_creation(s)
        raise 'Not yet implimented.'
        # TODO: deserializing
        tx = {}
        tx
      end

      # Deserialize a mosaic supply change transaction object
      # @param [String] serialized
      # @return [Hash]
      def self.mosaic_supply_change(s)
        tx = {}
        # s[0, 4] # Length of mosaic id structure
        ns_len = hexa2int(s[4, 4])
        mo_len = hexa2int(s[8 + ns_len, 4])
        tx[:mosaicId] = {
          namespaceId: hexa2ascii(s[8, ns_len]),
          name: hexa2ascii(s[8 + ns_len + mo_len, mo_len])
        }
        tx[:supplyType] = hexa2int(s[8 + ns_len + 4 + mo_len, 4])
        tx[:delta] = hexa2int(s[8 + ns_len + 4 + mo_len + 4, 8])
        tx
      end
    end
  end
end
