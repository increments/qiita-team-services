require "hipchat"

require "qiita/team/services/services/base"

module Qiita::Team::Services
  module Services
    class HipchatV1 < Base
      AVAILABLE_COLORS = %w(yellow red green purple random).freeze

      define_property :color, default: "yellow"
      define_property :from, default: "Qiita:Team"
      define_property :room
      define_property :token
      define_property :with_notification, default: false, type: :boolean

      validates :color, inclusion: AVAILABLE_COLORS
      validates :from, presence: true
      validates :room, presence: true
      validates :token, presence: true
      validates :with_notification, inclusion: [true, false]

      # @note Override {Services::Base.service_name}.
      def self.service_name
        "HipChat"
      end

      # @param event [Events::ItemCreated]
      # @return [void]
      def item_created(event)
        send_message "#{user_link(event.user)} created #{item_link(event.item)}."
      end

      # @param event [Events::ItemUpdated]
      # @return [void]
      def item_updated(event)
        send_message "#{user_link(event.user)} updated #{item_link(event.item)}."
      end

      # @param event [Events::ItemBecameCoediting]
      # @return [void]
      def item_became_coediting(event)
        send_message "#{user_link(event.user)} changed #{item_link(event.item)} to coedit mode."
      end

      # @param event [Events::CommentCreated]
      # @return [void]
      def comment_created(event)
        send_message <<-EOM.strip_heredoc
        #{user_link(event.user)} commented on #{item_link(event.item)}.
        <pre>#{event.comment.body.truncate(100)}</pre>
        EOM
      end

      # @param event [Events::MemberAdded]
      # @return [void]
      def team_member_added(event)
        send_message("#{user_link(event.member)} was added to #{event.team.name} team.")
      end

      # @param event [Events::ProjectCreated]
      # @return [void]
      def project_created(event)
        send_message("#{user_link(event.user)} created #{project_link(event.project)} project.")
      end

      # @param event [Events::ProjectUpdated]
      # @return [void]
      def project_updated(event)
        send_message("#{user_link(event.user)} updated #{project_link(event.project)} project.")
      end

      # @param event [Events::ProjectActivated]
      # @return [void]
      def project_activated(event)
        send_message("#{user_link(event.user)} activated #{project_link(event.project)} project.")
      end

      # @param event [Events::ProjectArchived]
      # @return [void]
      def project_archived(event)
        send_message("#{user_link(event.user)} archived #{event.project.name} project.")
      end

      private

      # @param message [String]
      def send_message(message)
        client.send(from, message, color: color, notify: with_notification)
      end

      # @return [HipChat::Client] configured with API v1.
      def client
        @client ||= HipChat::Client.new(token)[room]
      end

      # @param user [Resouces::User]
      # @return [String]
      def user_link(user)
        "<a href='#{user.url}'>#{user.name}</a>"
      end

      # @param item [Resouces::Item]
      # @return [String]
      def item_link(item)
        "<a href='#{item.url}'>#{item.title}</a>"
      end

      # @param project [Resouces::Project]
      # @return [String]
      def project_link(project)
        "<a href='#{project.url}'>#{project.name}</a>"
      end
    end
  end
end
