require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    class ProjectActivated < Event
      # @return [Resources::Project]
      alias_method :project, :resource

      # User who activated the project.
      #
      # @return [Resources::User]
      def user
        project.editor
      end
    end
  end
end
