module Nem
  module Mixin
    module MosaicDefinition
      def namespace_id(value)
        define_method "#{__method__}" do
          value
        end
      end

      def name(value)
        define_method "#{__method__}" do
          value
        end
      end

      def divisibility(value)
        define_method "#{__method__}" do
          value
        end
      end

      def initial_supply(value)
        define_method "#{__method__}" do
          value
        end
      end
    end
  end
end
