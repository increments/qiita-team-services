require "qiita/team/services/service"

module Qiita::Team::Services
  module Services
    class HipchatV1 < Service
      define_property :color, default: "yellow"
      define_property :room
      define_property :token
      define_property :with_notification, default: false, type: :boolean

      validates :color, inclusion: %w(yellow red green purple random)
      validates :room, presence: true
      validates :token, presence: true
      validates :with_notification, inclusion: [true, false]

      # @param _event [Events::ArticleCreated]
      # @return [void]
      def item_created(_event)
        fail NotImplementedError
      end

      # @param _event [Events::ArticleUpdated]
      # @return [void]
      def item_updated(_event)
        fail NotImplementedError
      end

      # @param _event [Events::CommentCreated]
      # @return [void]
      def comment_created(_event)
        fail NotImplementedError
      end

      # @param _event [Events::MemberAdded]
      # @return [void]
      def member_added(_event)
        fail NotImplementedError
      end

      # @param _event [Events::ProjectCreated]
      # @return [void]
      def project_created(_event)
        fail NotImplementedError
      end

      # @param _event [Events::ProjectUpdated]
      # @return [void]
      def project_updated(_event)
        fail NotImplementedError
      end
    end
  end
end
