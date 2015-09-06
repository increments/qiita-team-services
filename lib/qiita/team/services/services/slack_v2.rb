require "qiita/team/services/services/base"
require "qiita/team/services/services/concerns/slack"

module Qiita::Team::Services
  module Services
    class SlackV2 < Base
      include Concerns::Slack

      define_property :webhook_url

      validates :webhook_url, presence: true

      private

      # @note Implement Concerns::HttpClient#url.
      alias_method :url, :webhook_url
    end
  end
end
