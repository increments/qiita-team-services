module Qiita
  module Team
    module Services
    end
  end
end

require "qiita/team/services/event"
require "qiita/team/services/events/article_created"
require "qiita/team/services/events/article_updated"
require "qiita/team/services/events/comment_created"
require "qiita/team/services/events/member_added"
require "qiita/team/services/events/project_created"
require "qiita/team/services/events/project_updated"
require "qiita/team/services/service"
require "qiita/team/services/services/chatwork_v1"
require "qiita/team/services/services/hipchat_v1"
require "qiita/team/services/services/slack_v1"
require "qiita/team/services/services/slack_v2"
require "qiita/team/services/version"
