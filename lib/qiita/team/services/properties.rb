module Qiita::Team::Services
  module Properties
    class << self
      # @param name [Symbol]
      # @param type [Symbol] :string or :boolean.
      # @param default [String, true, false, nil]
      def create(name, type, default)
        # NOTE: Property name must be a string instance to serialize and
        #       deserialize correctly.
        case type
        when :string
          StringProperty.new(name.to_s, default)
        when :boolean
          BooleanProperty.new(name.to_s, default)
        else
          ArgumentError
        end
      end
    end
  end
end
