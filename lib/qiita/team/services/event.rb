require "active_support/inflector"

module Qiita::Team::Services
  # @abstract
  class Event
    class << self
      # List of defined event names.
      #
      # @return [Array<Symbol>]
      def event_names
        @event_names ||= []
      end

      private

      def inherited(child)
        event_names << child.name.demodulize.underscore.to_sym
      end
    end
  end
end
