require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectActivated < Base
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
