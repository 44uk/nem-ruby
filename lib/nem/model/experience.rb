module Nem
  module Model
    class Experience
      include Nem::Mixin::Assignable

      attr_reader :node, :syncs, :experience

      ExperienceData = Struct.new(:s, :f)

      def self.new_from_experience(hash)
        exp = hash[:experience]
        new(
          node: Nem::Model::Node.new_from_node(hash[:node]),
          syncs: hash[:syncs],
          experience: ExperienceData.new(exp[:s], exp[:f])
        )
      end
    end
  end
end
