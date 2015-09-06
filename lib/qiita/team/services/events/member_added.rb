require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class MemberAdded < Base
      # New team member.
      #
      # @return [Resources::User]
      alias_method :member, :resource
    end
  end
end
