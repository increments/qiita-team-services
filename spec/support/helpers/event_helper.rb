require "active_support/concern"

module Qiita::Team::Services
  module Helpers
    module EventHelper
      extend ActiveSupport::Concern

      {
        comment: [
          :created,
          :updated,
          :destroyed,
        ],
        item: [
          :became_coediting,
          :created,
          :updated,
          :destroyed,
        ],
        project: [
          :activated,
          :archived,
          :created,
          :updated,
          :destroyed,
        ],
        team_member: [
          :added,
          :removed,
        ],
      }.each_pair do |resource_name, action_names|
        action_names.each do |action_name|
          event_name = "#{resource_name}_#{action_name}"
          define_method "#{event_name}_event" do |resource = nil, user = nil, team = nil|
            resource ||= build(resource_name)
            user ||= build(:user)
            team ||= build(:team)
            Events.create(event_name, resource, user, team)
          end
        end
      end
    end
  end
end
