require "qiita/team/services/hooks/base"
require "qiita/team/services/hooks/concerns/slack"

module Qiita::Team::Services
  module Hooks
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
