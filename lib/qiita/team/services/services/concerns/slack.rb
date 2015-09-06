require "active_support/concern"
require "qiita/team/services/services/concerns/http_client"

module Qiita::Team::Services
  module Services
    module Concerns
      # Send richly-formatted messages to Slack.
      # Override {#url} to implement HttpClient.
      #
      # @see https://api.slack.com/docs/attachments
      module Slack
        extend ActiveSupport::Concern

        DEFAULT_ICON_URL = "https://cdn.qiita.com/media/qiita-team-slack-icon.png".freeze
        ICON_EMOJI_FORMAT = /\A:[^:]+:\z/

        included do
          include HttpClient

          define_property :username, default: "Qiita:Team"
          define_property :icon_emoji

          validates :username, presence: true
          validates :icon_emoji, format: { with: ICON_EMOJI_FORMAT }, allow_blank: true
        end

        # @param event [Events::ItemCreated]
        # @return [void]
        def item_created(event)
          fallback = "#{user_link(event.user)} created a new post"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.id}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
              title: event.item.title,
              title_link: event.item.url,
              text: Slacken.translate(event.item.rendered_body),
            ]
          )
        end

        # @param event [Events::ItemUpdated]
        # @return [void]
        def item_updated(event)
          fallback = "#{user_link(event.user)} updated #{item_link(event.item)}"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
            ]
          )
        end

        # @param event [Events::ItemBecameCoediting]
        # @return [void]
        def item_became_coediting(event)
          fallback = "#{user_link(event.user)} changed #{item_link(event.item)} to coedit mode"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
            ]
          )
        end

        # @param event [Events::CommentCreated]
        # @return [void]
        def comment_created(event)
          fallback =
            if event.item.coediting?
              "New comment on #{item_link(event.item)}"
            else
              "New comment on #{user_link(event.item.user)}'s #{item_link(event.item)}"
            end
          send_message(
            attachments: [
              fallback: fallback,
              pretext:fallback,
              author_name: "@#{event.user.id}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
              text: Slacken.translate(event.comment.rendered_body)
            ]
          )
        end

        # @param event [Events::MemberAdded]
        # @return [void]
        def member_added(event)
          fallback = "#{user_link(event.member)} is added to the #{team_link(event.team)} team"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
            ]
          )
        end

        # @param event [Events::ProjectCreated]
        # @return [void]
        def project_created(event)
          fallback = "#{user_link(event.user)} created #{project_link(event.project)} project"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.id}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
            ]
          )
        end

        # @param event [Events::ProjectUpdated]
        # @return [void]
        def project_updated(event)
          fallback = "#{user_link(event.user)} updated #{project_link(event.project)} project"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.id}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
            ]
          )
        end

        # @param event [Events::ProjectArchived]
        # @return [void]
        def project_archived(event)
          fallback = "#{user_link(event.user)} archived #{project_link(event.project)} project"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.id}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
            ]
          )
        end

        # @param event [Events::ProjectActivated]
        # @return [void]
        def project_activated(event)
          fallback = "#{user_link(event.user)} activated #{project_link(event.project)} project"
          send_message(
            attachments: [
              fallback: fallback,
              pretext: fallback,
              author_name: "@#{event.user.id}",
              author_link: event.user.url,
              author_icon: event.user.profile_image_url,
            ]
          )
        end

        private

        # @param request_body [Hash]
        # @return [void]
        def send_request(request_body)
          http_post(user_hash.merge(request_body))
        end

        # @return [Hash]
        def user_hash
          if icon_emoji.blank?
            { username: username, icon_url: DEFAULT_ICON_URL }
          else
            { username: username, icon_emoji: icon }
          end
        end

        # @param user [Resources::User]
        # @return [String]
        def user_link(user)
          "<#{user.url}|#{user.name}>"
        end

        # @param item [Resources::Item]
        # @return [String]
        def item_link(item)
          "<#{item.url}|#{item.title}>"
        end

        # @param project [Resources::Project]
        # @return [String]
        def project_link(project)
          "<#{project.url}|#{project.name}>"
        end

        # @param team [Resources::Team]
        # @return [String]
        def team_link(team)
          "<#{team.url}|#{team.name}>"
        end
      end
    end
  end
end
