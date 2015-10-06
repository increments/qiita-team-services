module Qiita::Team::Services
  module Hooks
    class << self
      # @return [Array<Qiita::Team::Services::Hooks::Base>]
      def all_hooks
        @all_hooks ||= []
      end

      # @return [Array<Qiita::Team::Services::Hooks::Base>]
      def active_hooks
        all_hooks.reject(&:deprecated?)
      end

      # @return [Array<Qiita::Team::Services::Hooks::Base>]
      def deprecated_hooks
        all_hooks.select(&:deprecated?)
      end

      # @return [Array<String>]
      def all_hook_types
        all_hooks.map(&:hook_type)
      end
    end
  end
end
