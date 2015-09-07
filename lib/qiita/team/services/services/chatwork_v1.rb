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

      # @param event [Events::ItemCreated]
      # @return [void]
      def item_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} created #{event.item.title}.
        #{event.item.url}
        EOM
      end

      # @param event [Events::ItemUpdated]
      # @return [void]
      def item_updated(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} updated #{event.item.title}.
        #{event.item.url}
        EOM
      end

      # @param event [Events::ItemBecameCoediting]
      # @return [void]
      def item_became_coediting(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} changed #{event.item.title} to coedit mode.
        #{event.item.url}
        EOM
      end

      # @param event [Events::CommentCreated]
      # @return [void]
      def comment_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} commented on #{event.item.title}.
        #{event.item.url}[info]#{event.comment.body.truncate(100)}[/info]
        EOM
      end

      # @param event [Events::MemberAdded]
      # @return [void]
      def team_member_added(event)
        send_message("#{event.member.name} is added to #{event.team.name} team.")
      end

      # @param event [Events::ProjectCreated]
      # @return [void]
      def project_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} created #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      # @param event [Events::ProjectUpdated]
      # @return [void]
      def project_updated(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} updated #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      # @param event [Events::ProjectArchived]
      # @return [void]
      def project_archived(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} archived #{event.project.name} project.
        #{event.project.url}
        EOM
      end

      # @param event [Events::ProjectActivated]
      # @return [void]
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
