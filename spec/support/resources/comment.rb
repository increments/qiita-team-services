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
    end
  end
end
