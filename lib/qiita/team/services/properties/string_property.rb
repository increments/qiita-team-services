require "qiita/team/services/property"

module Qiita::Team::Services
  module Properties
    class StringProperty < Property
      # @note Implement Property#default.
      def default
        @default.nil? ? "" : @default
      end
    end
  end
end
