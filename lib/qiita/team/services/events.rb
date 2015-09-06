module Qiita::Team::Services
  module Events
    class << self
      # List of defined event names.
      #
      # @return [Array<Symbol>]
      def event_names
        @event_names ||= []
      end
    end
  end
end
