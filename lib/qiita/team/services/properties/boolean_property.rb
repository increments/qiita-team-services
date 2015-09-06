require "qiita/team/services/property"

module Qiita::Team::Services
  module Properties
    class BooleanProperty < Property
      # @note Implement Property#default.
      def default
        @default.nil? ? true : @default
      end
    end
  end
end
