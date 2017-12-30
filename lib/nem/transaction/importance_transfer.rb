module Nem
  module Transaction
    # @attr [String] remote_account
    # @attr [Symbol] mode
    # @see https://nemproject.github.io/#importanceTransferTransaction
    class ImportanceTransfer < Nem::Transaction::Base
      TYPE = 0x0801 # 2049 (importance transfer transaction)

      ACTIVATE   = 0x0001
      DEACTIVATE = 0x0002

      attr_reader :mode, :remote_account

      def initialize(remote_account, mode, network: nil)
        @remote_account = remote_account
        @mode = mode

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::ImportanceTransfer.new(self)
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          mode: parse_mode,
          remoteAccount: remote_account
        }
      end

      private

      def parse_mode
        case mode
        when :activate   then ACTIVATE
        when :deactivate then DEACTIVATE
          else raise "Not implemented mode: #{mode}"
        end
      end
    end
  end
end
