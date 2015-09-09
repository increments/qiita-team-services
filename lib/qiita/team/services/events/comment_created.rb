require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class CommentCreated < Base
      # @return [Qiita::Team::Services::Resources::Comment]
      alias_method :comment, :resource

      # User who wrote the comment.
      #
      # @return [Qiita::Team::Services::Resources::User]
      delegate :user, to: :comment

      # Commented item.
      #
      # @return [Qiita::Team::Services::Resources::Item]
      delegate :item, to: :comment
    end
  end
end
