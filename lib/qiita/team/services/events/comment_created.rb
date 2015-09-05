require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    # @example Get a comment unique id.
    #
    #   event.comment.id
    #   #=> "3391f50c35f953abfc4f"
    #
    # @example Get comment body in HTML.
    #
    #   event.comment.rendered_body
    #   #=> "<h1>Example</h1>"
    #
    # @example Get comment body in Markdown.
    #
    #   event.comment.body
    #   #=> "# Example"
    #
    # @example Get datetime when this comment was created.
    #
    #   event.comment.created_at
    #   #=> 2000-01-01T00:00:00+00:00
    #
    # @example Get author id.
    #
    #   event.comment.user.id
    #   #=> "qiitan"
    #
    # @example Get author name.
    #
    #   event.comment.user.name
    #   #=> "Mr. Qiitan"
    #
    class CommentCreated < Event
      # @return [Api::Resources::Comment]
      alias_method :comment, :resource
    end
  end
end
