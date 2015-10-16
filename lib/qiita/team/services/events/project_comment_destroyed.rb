require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectCommentDestroyed < Base
      # @return [Qiita::Team::Services::Resources::Comment]
      alias_method :comment, :resource

      # Commented project.
      #
      # @return [Qiita::Team::Services::Resources::Project]
      def project
        comment.item
      end
    end
  end
end
