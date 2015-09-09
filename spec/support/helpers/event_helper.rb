require "active_support/concern"

module Qiita::Team::Services
  module Helpers
    module EventHelper
      extend ActiveSupport::Concern

      {
        comment: [
          :created,
        ],
        item: [
          :became_coediting,
          :created,
          :updated,
        ],
        project: [
          :activated,
          :archived,
          :created,
          :updated,
        ],
        team_member: [
          :added,
        ],
      }.each_pair do |resource_name, action_names|
        action_names.each do |action_name|
          event_name = "#{resource_name}_#{action_name}"
          define_method "#{event_name}_event" do |resource = nil|
            resource ||= build(resource_name)
            Events.create(event_name, resource)
          end
        end
      end
    end
  end
end
