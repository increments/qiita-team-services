require "active_support/concern"
require "active_support/core_ext/module/delegation"

module Qiita::Team::Services
  module Hooks
    module Concerns
      module EventHandlable
        extend ActiveSupport::Concern

        class_methods do
          # @return [true, false]
          def deprecated?
            @deprecated == true
          end

          # @return [true, false]
          def pingable?
            public_instance_methods.include?(:ping)
          end

          # List of implemented event names.
          #
          # @return [Array<Symbol>]
          def available_event_names
            public_instance_methods & Events.event_names
          end

          private

          # Mark the service as deprecated.
          #
          # @return [void]
          def deprecated
            @deprecated = true
          end
        end

        delegate :deprecated?, :pingable?, to: :class

        # @param event [Qiita::Team::Services::Events::Base]
        # @return [void]
        def handle(event)
          return unless respond_to?(event.class.event_name)
          public_send(event.class.event_name, event)
        end
      end
    end
  end
end
