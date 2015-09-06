require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    # @example Get added user id.
    #
    #   event.member.id
    #   #=> "qiitan"
    #
    # @example Get added user name.
    #
    #   event.member.name
    #   #=> "Mr. Qiitan"
    #
    class MemberAdded < Event
      # @return [Resources::User]
      alias_method :member, :resource
    end
  end
end
