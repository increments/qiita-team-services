require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    class ItemBecameCoediting < Event
      # @return [Resources::Item]
      alias_method :item, :resource

      # User who updated the item.
      #
      # @return [Resources::User]
      def user
        item.editor
      end
    end
  end
end