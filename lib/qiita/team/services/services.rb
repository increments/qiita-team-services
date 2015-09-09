module Qiita::Team::Services
  module Services
    class << self
      # @return [Array<Services::Base>]
      def all_services
        @all_services ||= []
      end

      # @return [Array<Services::Base>]
      def active_services
        all_services.reject(&:deprecated?)
      end

      # @return [Array<Services::Base>]
      def deprecated_services
        all_services.select(&:deprecated?)
      end

      # @return [Array<String>]
      def all_service_types
        all_services.map(&:service_type)
      end
    end
  end
end
