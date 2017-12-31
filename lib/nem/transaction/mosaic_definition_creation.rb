module Nem
  module Transaction
    # @attr [Nem::Model::MosaicDefinition] mosaic_definition
    # @attr [Integer] creation_fee
    # @attr [Integer] creation_fee_sink
    # @see https://nemproject.github.io/#mosaicDefinitionCreationTransaction
    class MosaicDefinitionCreation < Nem::Transaction::Base
      TYPE = 0x4001 # 16385 (mosaic definition creation transaction)

      attr_reader :mosaic_definition, :creation_fee, :creation_fee_sink

      def initialize(mosaic_definition, network: nil)
        @mosaic_definition = mosaic_definition
        @creation_fee = creation[:fee]
        @creation_fee_sink = creation[:sink]

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::MosaicDefinitionCreation.new(self)
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          mosaicDefinition: mosaic_definition.to_hash,
          creationFee: creation_fee,
          creationFeeSink: creation_fee_sink,
        }
      end

      private

      # @see http://www.nem.ninja/docs/#mosaics
      def creation
        if @network == :mainnet
          { sink: 'NBMOSAICOD4F54EE5CDMR23CCBGOAM2XSIUX6TRS',
            fee: 20 * 1_000_000 }
        else
          { sink: 'TBMOSAICOD4F54EE5CDMR23CCBGOAM2XSJBR5OLC',
            fee: 20 * 1_000_000 }
        end
      end
    end
  end
end
