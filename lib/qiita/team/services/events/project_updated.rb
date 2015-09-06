require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    # @example Get a project unique id.
    #
    #   event.project.id
    #   #=> 1
    #
    # @example Get name of prorject.
    #
    #   event.project.name
    #   #=> "Qiita project"
    #
    # @example Get project body in HTML.
    #
    #   event.project.rendered_body
    #   #=> "<h1>Example</h1>"
    #
    # @example Get project body in Markdown.
    #
    #   event.project.body
    #   #=> "# Example"
    #
    # @example Get datetime when this project was created.
    #
    #   event.project.created_at
    #   #=> 2000-01-01T00:00:00+00:00
    #
    # @example Get datetime when this project was updated.
    #
    #   event.project.updated_at
    #   #=> 2000-01-01T00:00:00+00:00
    #
    class ProjectUpdated < Event
      # @return [Api::Resources::Project]
      alias_method :project, :resource

      # User who updated the project.
      #
      # @return [Api::Resources::User]
      def user
        project.editor
      end
    end
  end
end
