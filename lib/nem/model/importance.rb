module Nem
  module Model
    class Importance
      include Nem::Mixin::Assignable

      attr_accessor :address,
        :score,
        :ev,
        :is_set,
        :height

      def self.new_from_account_importance_view_model(hash)
        importance = hash[:importance]
        new(
          address: hash[:address],
          score: importance[:score],
          ev: importance[:ev],
          is_set: importance[:isSet],
          height: importance[:height]
        )
      end

      # @return [Boolean]
      def set?
        @is_set == 1
      end
    end
  end
end
