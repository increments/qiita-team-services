require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ItemCreated < Base
      # @return [Qiita::Team::Services::Resources::Item]
      alias_method :item, :resource

      # User who created the item.
      #
      # @return [Qiita::Team::Services::Resources::User]
      delegate :user, to: :item
    end
  end
end
