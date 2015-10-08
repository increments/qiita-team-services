require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Project < Base
      attr_accessor :archived
      attr_accessor :body
      attr_accessor :comment_count
      attr_accessor :created_at
      attr_accessor :created_at_as_seconds
      attr_accessor :created_at_in_words
      attr_accessor :editor
      attr_accessor :id
      attr_accessor :message
      attr_accessor :name
      attr_accessor :rendered_body
      attr_accessor :tags
      attr_accessor :team
      attr_accessor :updated_at
      attr_accessor :updated_at_in_words
      attr_accessor :url
      attr_accessor :user

      alias_method :archived?, :archived

      webhook_property :archived
      webhook_property :body
      webhook_property :comment_count
      webhook_property :created_at
      webhook_property :created_at_as_seconds
      webhook_property :created_at_in_words
      webhook_property :id
      webhook_property :name
      webhook_property :raw_body
      webhook_property :tags
      webhook_property :updated_at
      webhook_property :updated_at_in_words
      webhook_property :url

      def raw_body
        body
      end
    end
  end
end
