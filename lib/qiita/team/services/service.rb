module Qiita::Team::Services
  # @abstract
  class Service
    class << self
      # @return [true, false]
      def deprecated?
        @deprecated == true
      end

      # @return [Array<Service>]
      def all_services
        @all_services ||= []
      end

      # @return [Array<Service>]
      def active_services
        all_services.reject(&:deprecated?)
      end

      # @return [Array<Service>]
      def deprecated_services
        all_services.select(&:deprecated?)
      end

      # List of implemented event names.
      #
      # @return [Array<Symbol>]
      def available_event_names
        public_instance_methods & Event.event_names
      end

      private

      def inherited(child)
        all_services << child
      end

      # Mark the service as deprecated.
      #
      # @param boolean [true, false]
      def deprecated
        @deprecated = true
      end
    end
  end
end
