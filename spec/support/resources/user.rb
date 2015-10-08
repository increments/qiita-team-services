require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class User < Base
      attr_accessor :id
      attr_accessor :url_name
      attr_accessor :name
      attr_accessor :url
      attr_accessor :profile_image_url

      webhook_property :id
      webhook_property :profile_image_url
      webhook_property :url_name
    end
  end
end
