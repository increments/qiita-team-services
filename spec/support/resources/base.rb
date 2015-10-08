module Qiita::Team::Services
  module Resources
    class Base
      def self.webhook_property(name)
        webhook_properties << name
      end

      def self.webhook_properties
        @webhook_properties ||= []
      end

      def as_json
        self.class.webhook_properties.each_with_object({}) do |property, hash|
          hash[property] = public_send(property).as_json
        end
      end

      def save!
        self
      end
    end
  end
end
