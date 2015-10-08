require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Comment < Base
      attr_accessor :id
      attr_accessor :body
      attr_accessor :rendered_body
      attr_accessor :url
      attr_accessor :item
      attr_accessor :team
      attr_accessor :user
      attr_accessor :created_at
      attr_accessor :updated_at

      webhook_property :id
      webhook_property :body
      webhook_property :raw_body
      webhook_property :url
      webhook_property :user
      webhook_property :created_at
      webhook_property :updated_at

      def raw_body
        body
      end
    end
  end
end
