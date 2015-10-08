require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Item < Base
      attr_accessor :body
      attr_accessor :coediting
      attr_accessor :comment_count
      attr_accessor :created_at
      attr_accessor :created_at_as_seconds
      attr_accessor :created_at_in_words
      attr_accessor :editor
      attr_accessor :id
      attr_accessor :lgtm_count
      attr_accessor :message
      attr_accessor :rendered_body
      attr_accessor :stock_count
      attr_accessor :stock_users
      attr_accessor :tags
      attr_accessor :title
      attr_accessor :updated_at
      attr_accessor :updated_at_in_words
      attr_accessor :url
      attr_accessor :user
      attr_accessor :uuid

      alias_method :coediting?, :coediting

      webhook_property :body
      webhook_property :coediting
      webhook_property :comment_count
      webhook_property :created_at
      webhook_property :created_at_as_seconds
      webhook_property :created_at_in_words
      webhook_property :id
      webhook_property :lgtm_count
      webhook_property :raw_body
      webhook_property :stock_count
      webhook_property :stock_users
      webhook_property :tags
      webhook_property :title
      webhook_property :updated_at
      webhook_property :updated_at_in_words
      webhook_property :url
      webhook_property :user
      webhook_property :uuid

      def raw_body
        body
      end
    end
  end
end
