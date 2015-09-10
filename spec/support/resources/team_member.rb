require "support/resources/base"

module Qiita::Team::Services
  module Resources
    class TeamMember < Base
      attr_accessor :team
      attr_accessor :id
      attr_accessor :name
      attr_accessor :url
      attr_accessor :profile_image_url
    end
  end
end
