require "active_model"

module Qiita::Team::Services
  # @abstract
  class Service
    include ActiveModel::Validations

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

      # @return [Array<Property>]
      def service_properties
        @service_properties ||= []
      end

      private

      def inherited(child)
        super
        all_services << child
      end

      # Mark the service as deprecated.
      #
      # @param boolean [true, false]
      def deprecated
        @deprecated = true
      end

      # @param name [Symbol]
      # @param type [Symbol] :string or :boolean.
      # @param default [String, true, false]
      # @return [void]
      def define_property(name, type: :string, default: nil)
        service_properties << Property.create(name, type, default)
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
