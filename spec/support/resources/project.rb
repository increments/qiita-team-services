require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Project < Base
      attr_accessor :team
      attr_accessor :id
      attr_accessor :name
      attr_accessor :body
      attr_accessor :rendered_body
      attr_accessor :url
      attr_accessor :user
      attr_accessor :editor
      attr_accessor :archived
      attr_accessor :created_at
      attr_accessor :updated_at

      alias_method :archived?, :archived
    end
  end
end
