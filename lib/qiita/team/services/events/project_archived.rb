require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectArchived < Base
      # @return [Qiita::Team::Services::Resources::Project]
      alias_method :project, :resource

      # User who archived the project.
      #
      # @return [Qiita::Team::Services::Resources::User]
      def user
        project.editor
      end
    end
  end
end
