require "qiita/team/services/properties"

module Qiita::Team::Services
  module Properties
    # @abstract
    class Base
      # @return [String]
      attr_reader :name

      def initialize(name, default)
        @name = name
        @default = default
      end

      def default
        fail NotImplementedError
      end
    end
  end
end
