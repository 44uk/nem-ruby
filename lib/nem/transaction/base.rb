module Nem
  module Transaction
    # @attr [Integer] type
    # @attr [Integer] fee
    # @attr [Integer] timestamp
    # @attr [Integer] deadline
    # @attr [String] signer
    # @attr [String] signature
    class Base
      attr_reader :type, :fee, :timestamp, :deadline,
        :signer, :signature

      {
        transfer: 0x0101,
        importance_transfer: 0x0801,
        multisig_aggregate_modification: 0x1001,
        multisig_signature: 0x1002,
        multisig: 0x1004,
        provision_namespace: 0x2001,
        mosaic_definition_creation: 0x4001,
        mosaic_supply_change: 0x4002,
      }.each do |k, v|
        define_method("#{k}?") { @type == v }
      end

      NETWORK = {
        testnet: 0x98 << 24,
        mainnet: 0x68 << 24,
        mijin: 0x60 << 24
      }

      NETWORK.each do |k, _|
        define_method("#{k}?") { @network == k }
      end

      def network(hex: false)
        hex ? NETWORK[@network] : @network
      end

      # it can be override by child class
      # @return [Integer]
      def version
        network(hex: true) + 1
      end

      def to_hash
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented."
      end
    end
  end
end
