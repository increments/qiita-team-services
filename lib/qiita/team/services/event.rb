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
        super
        event_names << child.name.demodulize.underscore.to_sym
      end
    end

    attr_reader :resource

    # @param resource [Api::Resources::Base]
    def initialize(resource)
      @resource = resource
    end
  end
end
