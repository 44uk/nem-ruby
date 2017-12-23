module Nem
  module Mixin
    module Assignable
      def initialize(attributes = {})
        attributes.each do |k, v|
          instance_variable_set("@#{k.to_s}", v) if respond_to?("#{k.to_s}")
        end if attributes
        yield self if block_given?
      end
    end
  end
end
