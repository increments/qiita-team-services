require "active_support/inflector"

require "qiita/team/services/events"

module Qiita::Team::Services
  module Events
    # @abstract
    class Base
      class << self
        # @return [Symbol]
        def event_name
          @event_name ||= name.demodulize.underscore.to_sym
        end

        private

        def inherited(child)
          super
          Events.event_names << child.event_name
        end
      end

      # Created/updated resource object.
      #
      # @return [Qiita::Team::Services::Resources::Base]
      attr_reader :resource

      # @param resource [Qiita::Team::Services::Resources::Base]
      def initialize(resource)
        @resource = resource
      end

      # User who emitted the event.
      #
      # @return [Qiita::Team::Services::Resources::User]
      def user
        fail NotImplementedError
      end

      # A team which the resource belongs to.
      #
      # @return [Qiita::Team::Services::Resources::Team]
      def team
        resource.team
      end
    end
  end
end
