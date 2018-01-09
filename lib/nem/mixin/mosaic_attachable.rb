module Nem
  module Mixin
    module MosaicAttachable
      extend Forwardable
      def_delegators :@mosaic_id, :fqn
      def_delegators :@properties,
        :divisibility,
        :initial_supply,
        :supply_mutable,
        :transferable

      attr_reader :mosaic_id, :quantity, :properties

      def initialize(quantity)
        mosaic_id = Nem::Model::MosaicId.new(
          namespace_id: namespace_id,
          name: name
        )
        properties = Nem::Model::MosaicProperties.new(
          divisibility: divisibility,
          initial_supply: initial_supply
        )
        @mosaic_id = mosaic_id
        @properties = properties
        @quantity = quantity
      end

      def amount
        return quantity * (10**properties.divisibility)
      end

      def self.included(base)
        base.send :prepend, self

        base.class_eval do
          def self.namespace_id(value)
            define_method "#{__method__}" do
              value
            end
          end

          def self.name(value)
            define_method "#{__method__}" do
              value
            end
          end

          def self.divisibility(value)
            define_method "#{__method__}" do
              value
            end
          end

          def self.initial_supply(value)
            define_method "#{__method__}" do
              value
            end
          end
        end
      end
    end
  end
end
