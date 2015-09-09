require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class Team < Base
      attr_accessor :id
      attr_accessor :name
      attr_accessor :url
    end
  end
end
