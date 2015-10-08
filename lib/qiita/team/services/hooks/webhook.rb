require "securerandom"

require "qiita/team/services/hooks/base"

module Qiita::Team::Services
  module Hooks
    class Webhook < Base
      include Concerns::HttpClient

      define_property :url
      define_property :token

      validates :token, format: %r{\A[A-Za-z0-9+/=]{20,40}\z}
      validates :url, presence: true

      # @note Override {Qiita::Team::Services::Hooks::Base.service_name}.
      def self.service_name
        "Webhook"
      end

      # @return [String]
      def self.generate_token
        SecureRandom.base64(20)
      end

      # @param hash [Hash{String => Object}]
      def initialize(hash)
        unless hash.key?("token")
          hash = hash.dup.merge("token" => self.class.generate_token)
        end
        super(hash)
      end

      def ping
        send_hook(
          action: "requested",
          message: "ping",
          model: "ping",
        )
      end

      # @param event [Qiita::Team::Services::Events::ItemCreated]
      def item_created(event)
        send_hook(
          action: "created",
          model: "item",
          item: event.resource,
          user: event.user,
        )
      end

      # @param event [Qiita::Team::Services::Events::ItemUpdated]
      def item_updated(event)
        send_hook(
          action: "updated",
          model: "item",
          message: event.resource.message,
          item: event.resource,
          user: event.user,
        )
      end

      # @param event [Qiita::Team::Services::Events::ItemDestroyed]
      def item_destroyed(event)
        send_hook(
          action: "destroyed",
          model: "item",
          item: event.resource,
        )
      end

      # @param event [Qiita::Team::Services::Events::CommentCreated]
      def comment_created(event)
        send_hook(
          action: "created",
          model: "comment",
          comment: event.resource,
          item: event.item,
        )
      end

      # @param event [Qiita::Team::Services::Events::CommentUpdated]
      def comment_updated(event)
        send_hook(
          action: "updated",
          model: "comment",
          comment: event.resource,
          item: event.item,
        )
      end

      # @param event [Qiita::Team::Services::Events::CommentDestroyed]
      def comment_destroyed(event)
        send_hook(
          action: "destroyed",
          model: "comment",
          comment: event.resource,
          item: event.item,
        )
      end

      # @param event [Qiita::Team::Services::Events::TeamMemberAdded]
      def team_member_added(event)
        send_hook(
          action: "added",
          model: "member",
          user: event.resource,
        )
      end

      # @param event [Qiita::Team::Services::Events::TeamMemberRemoved]
      def team_member_removed(event)
        send_hook(
          action: "removed",
          model: "member",
          user: event.resource,
        )
      end

      # @param event [Qiita::Team::Services::Events::ProjectCreated]
      def project_created(event)
        send_hook(
          action: "created",
          model: "project",
          project: event.resource,
          user: event.user,
        )
      end

      # @param event [Qiita::Team::Services::Events::ProjectUpdated]
      def project_updated(event)
        send_hook(
          action: "updated",
          model: "project",
          message: event.resource.message,
          project: event.resource,
          user: event.user,
        )
      end

      # @param event [Qiita::Team::Services::Events::ProjectDestroyed]
      def project_destroyed(event)
        send_hook(
          action: "destroyed",
          model: "project",
          project: event.resource,
        )
      end

      private

      def send_hook(properties)
        http_post(
          properties.as_json,
          {
            "X-Qiita-Event-Model" => properties[:model],
            "X-Qiita-Token" => token,
          }.reject { |_key, value| value.nil? },
        )
      end
    end
  end
end
