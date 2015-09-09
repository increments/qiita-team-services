require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectCreated < Base
      # @return [Qiita::Team::Services::Resources::Project]
      alias_method :project, :resource

      # User who created the project.
      #
      # @return [Qiita::Team::Services::Resources::User]
      delegate :user, to: :project
    end
  end
end
