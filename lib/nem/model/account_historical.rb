module Nem
  module Model
    class AccountHistorical
      include Nem::Mixin::Assignable

      attr_reader :page_rank,
        :address,
        :balance,
        :importance,
        :vested_balance,
        :unvested_balance,
        :height

      def self.new_from_account_historical(hash)
        new(hash)
      end
    end
  end
end
