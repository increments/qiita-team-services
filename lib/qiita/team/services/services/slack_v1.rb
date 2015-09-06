require "qiita/team/services/services/base"
require "qiita/team/services/services/concerns/slack"

module Qiita::Team::Services
  module Services
    class SlackV1 < Base
      deprecated

      include Concerns::Slack

      define_property :teamname
      define_property :integration_token

      validates :teamname, presence: true
      validates :integration_token, presence: true

      private

      # @note Implement Concerns::HttpClient#url.
      def url
        "https://#{teamname}.slack.com/services/hooks/incoming-webhook?token=#{integration_token}"
      end
    end
  end
end
