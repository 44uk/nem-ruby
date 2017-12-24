module Nem
  module Model
    class Keypair
      include Nem::Mixin::Assignable

      attr_reader :private_key,
        :public_key,
        :address

      def self.new_from_key_pair_view_model(hash)
        new(
          private_key: hash[:privateKey],
          public_key: hash[:publicKey],
          address: hash[:address]
        )
      end
    end
  end
end
