module Nem
  module Model
    class MosaicProperties
      include Nem::Mixin::Assignable

      attr_reader :divisibility,
        :initial_supply,
        :supply_mutable,
        :transferable

      def self.new_from_mosaic_properties(hash)
        props = hash.inject({}) do |memo, prop|
          memo[prop[:name]] = case prop[:name]
                              when 'divisibility'  then prop[:value].to_i
                              when 'initialSupply' then prop[:value].to_i
                              when 'supplyMutable' then prop[:value] == 'true' ? true : false
                              when 'transferable'  then prop[:value] == 'true' ? true : false
            else prop[:value]
          end
          memo
        end
        new(
          divisibility: props['divisibility'],
          initial_supply: props['initialSupply'],
          supply_mutable: props['supplyMutable'],
          transferable: props['transferable']
        )
      end

      def to_a
        [
          { name: 'divisibility', value: divisibility.to_s },
          { name: 'initialSupply', value: initial_supply.to_s },
          { name: 'supplyMutable', value: supply_mutable ? 'true' : 'false' },
          { name: 'transferable', value: transferable ? 'true' : 'false' }
        ]
      end

      def to_hash
        to_a
      end
    end
  end
end
