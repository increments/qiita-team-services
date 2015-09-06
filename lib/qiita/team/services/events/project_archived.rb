require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    class ProjectArchived < Event
      # @return [Resources::Project]
      alias_method :project, :resource

      # User who archived the project.
      #
      # @return [Resources::User]
      def user
        project.editor
      end
    end
  end
end
