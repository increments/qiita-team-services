require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    class MemberAdded < Event
      # New team member.
      #
      # @return [Resources::User]
      alias_method :member, :resource
    end
  end
end
