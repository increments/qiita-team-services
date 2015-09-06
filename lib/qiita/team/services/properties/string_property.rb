require "qiita/team/services/properties/base"

module Qiita::Team::Services
  module Properties
    class StringProperty < Base
      # @note Implement {Base#default}.
      def default
        @default.nil? ? "" : @default
      end
    end
  end
end
