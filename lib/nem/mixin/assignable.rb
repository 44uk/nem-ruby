module Nem
  module Mixin
    module Assignable
      def initialize(attributes = {})
        attributes.each do |k, v|
          instance_variable_set("@#{k.to_s}", v) if respond_to?("#{k.to_s}")
          # NOTE: debugging
          if Nem.debug && !respond_to?("#{k.to_s}")
            Nem.logger.warn "Detected unknown key-value. #{k} => #{v} on #{self.class.name}"
          end
        end if attributes
        yield self if block_given?
      end
    end
  end
end
