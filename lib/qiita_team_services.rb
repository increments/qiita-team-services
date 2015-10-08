module Qiita
  module Team
    module Services
    end
  end
end

require "qiita/team/services/engine"
require "qiita/team/services/errors"
require "qiita/team/services/events/comment_created"
require "qiita/team/services/events/comment_destroyed"
require "qiita/team/services/events/comment_updated"
require "qiita/team/services/events/item_became_coediting"
require "qiita/team/services/events/item_created"
require "qiita/team/services/events/item_destroyed"
require "qiita/team/services/events/item_updated"
require "qiita/team/services/events/project_activated"
require "qiita/team/services/events/project_archived"
require "qiita/team/services/events/project_created"
require "qiita/team/services/events/project_destroyed"
require "qiita/team/services/events/project_updated"
require "qiita/team/services/events/team_member_added"
require "qiita/team/services/events/team_member_removed"
require "qiita/team/services/properties/boolean_property"
require "qiita/team/services/properties/string_property"
require "qiita/team/services/hooks/chatwork_v1"
require "qiita/team/services/hooks/hipchat_v1"
require "qiita/team/services/hooks/slack_v1"
require "qiita/team/services/hooks/slack_v2"
require "qiita/team/services/hooks/webhook"
require "qiita/team/services/version"
