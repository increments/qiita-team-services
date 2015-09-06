require "active_support/concern"

module Qiita::Team::Services
  module Services
    module Concerns
      module Slack
        extend ActiveSupport::Concern

        ICON_EMOJI_FORMAT = /\A:[^:]+:\z/

        included do
          define_property :username, default: "Qiita:Team"
          define_property :icon_emoji

          validates :username, presence: true
          validates :icon_emoji, format: { with: ICON_EMOJI_FORMAT }, allow_blank: true
        end
      end
    end
  end
end
