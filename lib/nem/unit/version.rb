module Nem
  module Unit
    # @attr [String] value
    class Version
      TESTNET = 0x98 << 24 # -1744830464
      MAINNET = 0x68 << 24 #  1744830464
      MIJIN   = 0x60 << 24

      MASK_VERSION = 0x00000003
      MASK_NETWORK = 0xfffffffc

      attr_accessor :value

      def initialize(value)
        @value = value
      end

      # @return [Integer]
      def version
        @version ||= value & MASK_VERSION
      end

      # @return [Integer]
      def network
        @network ||= value & MASK_NETWORK
      end

      %w[testnet mainnet mijin].each do |k|
        # @return [Boolean]
        define_method("#{k}?") {
        network == self.class.const_get(k.upcase) }
      end

      # @return [String]
      def to_s
        to_i.to_s
      end

      # @return [Integer]
      def to_i
        value.to_i
      end

      # @return [Boolean]
      def ==(other)
        version == other
      end
    end
  end
end
