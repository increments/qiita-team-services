require "active_support/concern"
require "active_support/inflector"

module Qiita::Team::Services
  module Hooks
    module Concerns
      module Service
        extend ActiveSupport::Concern

        class_methods do
          # @return [String]
          def service_type
            name.demodulize.underscore
          end

          # @return [String]
          def service_name
            fail NotImplementedError
          end
        end

        # The service name.
        #
        # @return [String]
        def name
          self.class.service_name
        end
      end
    end
  end
end
