require "active_support/concern"
require "slacken"

require "qiita/team/services/hooks/concerns/http_client"

module Qiita::Team::Services
  module Hooks
    module Concerns
      # Send richly-formatted messages to Slack.
      # Override {HttpClient#url} to implement HttpClient.
      #
      # @see https://api.slack.com/docs/attachments
      module Slack
        extend ActiveSupport::Concern

        DEFAULT_ICON_URL = "https://cdn.qiita.com/media/qiita-team-slack-icon.png".freeze
        ICON_EMOJI_FORMAT = /\A:[^:]+:\z/
        TEXT_BYTESIZE_MAX = 7500

        included do
          include HttpClient

          define_property :username, default: "Qiita:Team"
          define_property :icon_emoji

          validates :username, presence: true
          validates :icon_emoji, format: { with: ICON_EMOJI_FORMAT }, allow_blank: true
        end

        class_methods do
          # @note Override {Services::Base.service_name}.
          def service_name
            "Slack"
          end
        end

        # @return [void]
        def ping
          send_message(text: "Test message sent from Qiita:Team")
        rescue DeliveryError
          nil
        end

        # @param event [Qiita::Team::Services::Events::ItemCreated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_created(event)
          fallback = "#{user_link(event.user)} created a new post"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.url_name}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
              title: event.item.title,
              title_link: event.item.url,
              text: truncate(Slacken.translate(event.item.rendered_body), event.item.url),
              mrkdwn_in: ["text"],
            ],
          )
        end

        # @param event [Qiita::Team::Services::Events::ItemUpdated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_updated(event)
          send_message(
            text: "#{user_link(event.user)} updated #{item_link(event.item)}",
          )
        end

        # @param event [Qiita::Team::Services::Events::ItemBecameCoediting]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_became_coediting(event)
          send_message(
            text: "#{user_link(event.user)} changed #{item_link(event.item)} to coedit mode",
          )
        end

        # @param event [Qiita::Team::Services::Events::ItemDestroyed]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_destroyed(event)
          send_message(
            text: "#{user_link(event.user)} deleted #{event.item.title}",
          )
        end

        # @param event [Qiita::Team::Services::Events::ItemCommentCreated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_comment_created(event)
          fallback =
            if event.item.coediting?
              "New #{comment_link(event.comment)} on #{item_link(event.item)}"
            else
              "New #{comment_link(event.comment)} on #{user_link(event.item.user)}'s " \
              "#{item_link(event.item)}"
            end
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.url_name}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
              text: truncate(Slacken.translate(event.comment.rendered_body), event.comment.url),
              mrkdwn_in: ["text"],
            ],
          )
        end

        # @param event [Qiita::Team::Services::Events::ItemCommentUpdated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_comment_updated(event)
          text = "#{user_link(event.user)} updated a #{comment_link(event.comment)}"
          text << " on #{item_link(event.item)}"
          send_message(text: text)
        end

        # @param event [Qiita::Team::Services::Events::ItemCommentDestroyed]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def item_comment_destroyed(event)
          send_message(
            text: "#{user_link(event.user)} deleted a comment on #{item_link(event.item)}",
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectCommentCreated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_comment_created(event)
          fallback = "New #{comment_link(event.comment)} on #{project_link(event.project)}"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.url_name}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
              text: truncate(Slacken.translate(event.comment.rendered_body), event.comment.url),
              mrkdwn_in: ["text"],
            ],
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectCommentUpdated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_comment_updated(event)
          text = "#{user_link(event.user)} updated a #{comment_link(event.comment)}"
          text << " on #{project_link(event.project)}"
          send_message(text: text)
        end

        # @param event [Qiita::Team::Services::Events::ProjectCommentDestroyed]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_comment_destroyed(event)
          send_message(
            text: "#{user_link(event.user)} deleted a comemnt on #{project_link(event.project)}",
          )
        end

        # @param event [Qiita::Team::Services::Events::MemberAdded]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def team_member_added(event)
          send_message(
            text: "#{user_link(event.member)} was added to the #{team_link(event.team)} team",
          )
        end

        # @param event [Qiita::Team::Services::Events::MemberRemoved]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def team_member_removed(event)
          send_message(
            text: "#{event.member.name} was removed from the #{team_link(event.team)} team",
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectCreated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_created(event)
          send_message(
            text: "#{user_link(event.user)} created #{project_link(event.project)} project",
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectUpdated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_updated(event)
          send_message(
            text: "#{user_link(event.user)} updated #{project_link(event.project)} project",
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectDestroyed]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_destroyed(event)
          send_message(
            text: "#{user_link(event.user)} deleted #{project_link(event.project)} project",
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectArchived]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_archived(event)
          send_message(
            text: "#{user_link(event.user)} archived #{project_link(event.project)} project",
          )
        end

        # @param event [Qiita::Team::Services::Events::ProjectActivated]
        # @return [void]
        # @raise [Qiita::Team::Services::DeliveryError]
        def project_activated(event)
          send_message(
            text: "#{user_link(event.user)} activated #{project_link(event.project)} project",
          )
        end

        private

        # @param request_body [Hash]
        # @return [void]
        def send_message(request_body)
          http_post(user_hash.merge(request_body))
        end

        # @return [Hash]
        def user_hash
          if icon_emoji.blank?
            { username: username, icon_url: DEFAULT_ICON_URL }
          else
            { username: username, icon_emoji: icon_emoji }
          end
        end

        # @param user [Qiita::Team::Services::Resources::User]
        # @return [String]
        def user_link(user)
          "<#{user.url}|#{markup_escape(user.name)}>"
        end

        # @param item [Qiita::Team::Services::Resources::Item]
        # @return [String]
        def item_link(item)
          "<#{item.url}|#{markup_escape(item.title)}>"
        end

        # @param comment [Qiita::Team::Services::Resources::Comment]
        # @return [String]
        def comment_link(comment)
          "<#{comment.url}|comment>"
        end

        # @param project [Qiita::Team::Services::Resources::Project]
        # @return [String]
        def project_link(project)
          "<#{project.url}|#{markup_escape(project.name)}>"
        end

        # @param team [Qiita::Team::Services::Resources::Team]
        # @return [String]
        def team_link(team)
          "<#{team.url}|#{markup_escape(team.name)}>"
        end

        # Escape special characters for Slack markup.
        #
        # @see https://api.slack.com/docs/formatting
        # @param text [String]
        # @return [String]
        def markup_escape(text)
          table_for_escape = {
            "&" => "&amp;",
            "<" => "&lt;",
            ">" => "&gt;",
          }
          text.gsub(/[&<>]/, table_for_escape)
        end

        # Truncate the text to 7500 bytes.
        # Now, Slack has a bug that we cannot send text larger than 8000 bytes.
        #
        # @param text [String]
        # @param url [String]
        # @return [String]
        def truncate(text, url)
          return text if text.bytesize <= TEXT_BYTESIZE_MAX
          tail = "...\n<#{url}|Read more at Qiita:Team...>"
          text.byteslice(0, TEXT_BYTESIZE_MAX - tail.bytesize).scrub("") + tail
        end
      end
    end
  end
end
