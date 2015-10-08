require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Tagging < Base
      attr_accessor :name
      attr_accessor :url_name
      attr_accessor :versions

      webhook_property :name
      webhook_property :url_name
      webhook_property :versions
    end
  end
end
