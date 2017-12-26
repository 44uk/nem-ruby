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
        new(
          page_rank: hash[:pageRank],
          address: hash[:address],
          balance: hash[:balance],
          importance: hash[:importance],
          vested_balance: hash[:vestedBalance],
          unvested_balance: hash[:unvestedBalance],
          height: hash[:height]
        )
      end
    end
  end
end
