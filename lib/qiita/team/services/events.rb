module Qiita::Team::Services
  module Events
    class << self
      # List of defined event names.
      #
      # @return [Array<Symbol>]
      def event_names
        @event_names ||= []
      end

      # @param event_name [Symbol]
      # @param resource [Qiita::Team::Services::Resources::Base]
      # @param actor [Qiita::Team::Services::Resources::TeamMember]
      # @return [Qiita::Team::Services::Events::Base]
      def create(event_name, resource, actor)
        event_class(event_name).new(resource, actor)
      end

      private

      # @param event_name [String]
      def event_class(event_name)
        "Qiita::Team::Services::Events::#{event_name.to_s.camelize}".constantize
      end
    end
  end
end
