require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class TeamMemberAdded < Base
      # New team member.
      #
      # @return [Qiita::Team::Services::Resources::User]
      alias_method :member, :resource
    end
  end
end
