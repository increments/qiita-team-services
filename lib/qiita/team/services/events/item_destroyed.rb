require "qiita/team/services/events/base"

module Qiita::Team::Services
  module Events
    class ItemDestroyed < Base
      # @return [Qiita::Team::Services::Resources::Item]
      alias_method :item, :resource
    end
  end
end
