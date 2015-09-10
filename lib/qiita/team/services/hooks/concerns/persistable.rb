require "active_support/concern"

require "qiita/team/services/properties"

module Qiita::Team::Services
  module Hooks
    module Concerns
      module Persistable
        extend ActiveSupport::Concern

        class_methods do
          # @return [Array<Qiita::Team::Services::Properties::Base>]
          def service_properties
            @service_properties ||= []
          end

          # @return [Array<String>]
          def property_names
            service_properties.map(&:name)
          end

          private

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

        # Returns whether or not this record will be destroyed as part of
        # the parents save transaction.
        #
        # @note Override ActiveRecord::AutosaveAssociation#marked_for_destruction?.
        def marked_for_destruction?
          false
        end
      end
    end
  end
end
