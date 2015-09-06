require "qiita/team/services/service"

module Qiita::Team::Services
  module Services
    class ChatworkV1 < Service
      define_property :token
      define_property :room_id

      validates :token, presence: true
      validates :room_id, presence: true

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
