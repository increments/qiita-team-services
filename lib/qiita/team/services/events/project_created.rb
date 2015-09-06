require "active_support/core_ext/module/delegation"

require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    class ProjectCreated < Event
      # @return [Resources::Project]
      alias_method :project, :resource

      # User who created the project.
      #
      # @return [Resources::User]
      delegate :user, to: :project
    end
  end
end
