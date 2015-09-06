module Qiita::Team::Services
  class Property
    # @return [String]
    attr_reader :name

    # @param name [Symbol]
    # @param type [Symbol] :string or :boolean.
    # @param default [String, true, false, nil]
    def self.create(name, type, default)
      # NOTE: Property name must be a string instance to serialize and
      #       deserialize correctly.
      case type
      when :string
        Properties::StringProperty.new(name.to_s, default)
      when :boolean
        Properties::BooleanProperty.new(name.to_s, default)
      else
        ArgumentError
      end
    end

    def initialize(name, default)
      @name = name
      @default = default
    end

    def default
      fail NotImplementedError
    end
  end
end
