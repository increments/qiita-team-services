require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    # @example Get user id.
    #
    #   event.user.id
    #   #=> "qiitan"
    #
    # @example Get user name.
    #
    #   event.user.name
    #   #=> "Mr. Qiitan"
    #
    class MemberAdded < Event
      # @return [Api::Resources::User]
      alias_method :user, :resource
    end
  end
end
