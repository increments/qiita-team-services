require "active_support/core_ext/module/delegation"

require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectCreated < Base
      # @return [Qiita::Team::Services::Resources::Project]
      alias_method :project, :resource
    end
  end
end
