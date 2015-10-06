require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Tagging < Base
      attr_accessor :name
      attr_accessor :url_name
      attr_accessor :versions
    end
  end
end
