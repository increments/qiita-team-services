require "active_model"
require "active_support/inflector"

require "qiita/team/services/services"

module Qiita::Team::Services
  module Services
    # @abstract
    class Base
      include ActiveModel::Validations

      class << self
        # @return [true, false]
        def deprecated?
          @deprecated == true
        end

        # List of implemented event names.
        #
        # @return [Array<Symbol>]
        def available_event_names
          public_instance_methods & Events.event_names
        end

        # @return [Array<Properties::Base>]
        def service_properties
          @service_properties ||= []
        end

        # @return [String]
        def service_type
          name.demodulize.underscore
        end

        private

        def inherited(child)
          super
          Services.all_services << child
        end

        # Mark the service as deprecated.
        #
        # @return [void]
        def deprecated
          @deprecated = true
        end

        # @param name [Symbol]
        # @param type [Symbol] :string or :boolean.
        # @param default [String, true, false]
        # @return [void]
        def define_property(name, type: :string, default: nil)
          service_properties << Properties.create(name, type, default)
          attr_accessor name
        end
      end

      # @param hash [Hash{String => Object}] deserialized properties hash.
      def initialize(hash)
        self.class.service_properties.each do |property|
          if hash.key?(property.name)
            public_send("#{property.name}=", hash[property.name])
          else
            public_send("#{property.name}=", property.default)
          end
        end
      end

      # Serialize the service object.
      #
      # @return [Hash{String => Object}] serialized properties.
      def to_hash
        self.class.service_properties.map(&:name).each_with_object({}) do |name, hash|
          hash[name] = public_send(name)
        end
      end
    end
  end
end
