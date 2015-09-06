require "qiita/team/services/properties/base"

module Qiita::Team::Services
  module Properties
    class BooleanProperty < Base
      # @note Implement {Base#default}.
      def default
        @default.nil? ? true : @default
      end
    end
  end
end
