require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectUpdated < Base
      # @return [Resources::Project]
      alias_method :project, :resource

      # User who updated the project.
      #
      # @return [Resources::User]
      def user
        project.editor
      end
    end
  end
end
