require "active_support/inflector"

require "qiita/team/services/events"

module Qiita::Team::Services
  module Events
    # @abstract
    class Base
      class << self
        private

        def inherited(child)
          super
          Events.event_names << child.name.demodulize.underscore.to_sym
        end
      end

      # Created/updated resource object.
      #
      # @return [Resources::Base]
      attr_reader :resource

      # A team which the resource belongs to.
      #
      # @return [Resources::Team]
      attr_reader :team

      # @param resource [Resources::Base]
      # @param team [Resources::Team]
      def initialize(resource, team)
        @resource = resource
        @team = team
      end

      # User who emitted the event.
      #
      # @return [Resources::User]
      def user
        fail NotImplementedError
      end
    end
  end
end
