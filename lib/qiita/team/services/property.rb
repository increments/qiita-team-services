module Qiita::Team::Services
  class Property
    # @return [String]
    attr_reader :name

    # @param name [Symbol]
    # @param type [Symbol] :string or :boolean.
    def self.create(name, type)
      # NOTE: Property name must be a string instance to serialize and
      #       deserialize correctly.
      case type
      when :string
        Properties::StringProperty.new(name.to_s)
      when :boolean
        Properties::BooleanProperty.new(name.to_s)
      else
        ArgumentError
      end
    end

    def initialize(name)
      @name = name
    end
  end
end
