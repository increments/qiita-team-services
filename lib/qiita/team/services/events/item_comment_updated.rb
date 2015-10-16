require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ItemCommentUpdated < Base
      # @return [Qiita::Team::Services::Resources::Comment]
      alias_method :comment, :resource

      # Commented item.
      #
      # @return [Qiita::Team::Services::Resources::Item]
      delegate :item, to: :comment
    end
  end
end
