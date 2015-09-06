require "active_support/core_ext/string/strip"

require "qiita/team/services/service"
require "qiita/team/services/services/concerns/http_client"

module Qiita::Team::Services
  module Services
    class ChatworkV1 < Service
      include Concerns::HttpClient

      define_property :token
      define_property :room_id

      validates :token, presence: true
      validates :room_id, presence: true

      # @param event [Events::ArticleCreated]
      # @return [void]
      def item_created(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} created #{event.item.title}.
        #{event.item.url}
        EOM
      end

      # @param event [Events::ArticleUpdated]
      # @return [void]
      def item_updated(event)
        send_message <<-EOM.strip_heredoc
        #{event.user.name} updated #{event.item.title}.
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
      def member_added(event)
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
