require "active_support/core_ext/string/strip"

require "qiita/team/services/services/base"
require "qiita/team/services/services/concerns/http_client"

module Qiita::Team::Services
  module Services
    class ChatworkV1 < Base
      include Concerns::HttpClient

      define_property :token
      define_property :room_id

      validates :token, presence: true
      validates :room_id, presence: true

      # @note Override {Services::Base.service_name}.
      def self.service_name
        "ChatWork"
      end

      # @return [void]
      def ping
        send_message "Test message sent from Qiita:Team"
      rescue DeliveryError
        nil
      end

      # @param event [Qiita::Team::Services::Events::ItemCreated]
      # @return [void]
      # @raise [DeliveryError]
      def item_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} created #{event.item.title}.
        #{event.item.url}
        EOM
      end

      # @param event [Qiita::Team::Services::Events::ItemUpdated]
      # @return [void]
      # @raise [DeliveryError]
      def item_updated(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} updated #{event.item.title}.
        #{event.item.url}
        EOM
      end

      # @param event [Qiita::Team::Services::Events::ItemBecameCoediting]
      # @return [void]
      # @raise [DeliveryError]
      def item_became_coediting(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} changed #{event.item.title} to coedit mode.
        #{event.item.url}
        EOM
      end

      # @param event [Qiita::Team::Services::Events::CommentCreated]
      # @return [void]
      # @raise [DeliveryError]
      def comment_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} commented on #{event.item.title}.
        #{event.item.url}[info]#{event.comment.body.truncate(100)}[/info]
        EOM
      end

      # @param event [Qiita::Team::Services::Events::MemberAdded]
      # @return [void]
      # @raise [DeliveryError]
      def team_member_added(event)
        send_message("#{event.member.name} is added to #{event.team.name} team.")
      end

      # @param event [Qiita::Team::Services::Events::ProjectCreated]
      # @return [void]
      # @raise [DeliveryError]
      def project_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} created #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      # @param event [Qiita::Team::Services::Events::ProjectUpdated]
      # @return [void]
      # @raise [DeliveryError]
      def project_updated(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} updated #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      # @param event [Qiita::Team::Services::Events::ProjectArchived]
      # @return [void]
      # @raise [DeliveryError]
      def project_archived(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} archived #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      # @param event [Qiita::Team::Services::Events::ProjectActivated]
      # @return [void]
      # @raise [DeliveryError]
      def project_activated(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} activated #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      private

      # @param message [String]
      def send_message(message)
        http_post({ body: message }.to_query)
      end

      # @note Override Concerns::HttpClient#url.
      def url
        "https://api.chatwork.com/v1/rooms/#{room_id}/messages"
      end

      # @note Override Concerns::HttpClient#request_format.
      def request_format
        :url_encoded
      end

      # @note Override Concerns::HttpClient#request_headers.
      def request_headers
        { "X-ChatWorkToken" => token }
      end
    end
  end
end
