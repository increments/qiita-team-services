require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ItemCreated < Base
      # @return [Resources::Item]
      alias_method :item, :resource

      # User who created the item.
      #
      # @return [Resources::User]
      delegate :user, to: :item
    end
  end
end
