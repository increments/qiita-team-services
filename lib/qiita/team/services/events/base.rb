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

      # @param resource [Qiita::Team::Services::Resources::Base]
      # @param user [Qiita::Team::Services::Resources::User]
      def initialize(resource, user, team)
        @resource = resource
        @user = user
        @team = team
      end

      # Created/updated resource object.
      #
      # @return [Qiita::Team::Services::Resources::Base]
      attr_reader :resource

      # User who emitted the event.
      #
      # @return [Qiita::Team::Services::Resources::User]
      attr_reader :user

      # A team which the resource belongs to.
      #
      # @return [Qiita::Team::Services::Resources::Team]
      attr_reader :team
    end
  end
end
