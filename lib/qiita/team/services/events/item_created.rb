require "active_support/core_ext/module/delegation"

require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    class ItemCreated < Event
      # @return [Resources::Item]
      alias_method :item, :resource

      # User who created the item.
      #
      # @return [Resources::User]
      delegate :user, to: :item
    end
  end
end
