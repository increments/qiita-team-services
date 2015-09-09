require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ItemBecameCoediting < Base
      # @return [Qiita::Team::Services::Resources::Item]
      alias_method :item, :resource

      # User who updated the item.
      #
      # @return [Qiita::Team::Services::Resources::User]
      def user
        item.editor
      end
    end
  end
end
