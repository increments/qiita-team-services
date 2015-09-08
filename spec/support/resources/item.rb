require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Item < Base
      attr_accessor :team
      attr_accessor :user
      attr_accessor :id
      attr_accessor :title
      attr_accessor :body
      attr_accessor :rendered_body
      attr_accessor :url
      attr_accessor :coediting
      attr_accessor :user
      attr_accessor :editor
      attr_accessor :tags
      attr_accessor :created_at
      attr_accessor :updated_at

      alias_method :coediting?, :coediting
    end
  end
end
