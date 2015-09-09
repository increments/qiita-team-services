require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ProjectDestroyed < Base
      # @return [Qiita::Team::Services::Resources::Project]
      alias_method :project, :resource
    end
  end
end
