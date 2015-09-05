require "qiita/team/services/event"

module Qiita::Team::Services
  module Events
    # @example Get an item unique id.
    #
    #   event.item.id
    #   #=> "4bd431809afb1bb99e4f"
    #
    # @example Get item body in HTML.
    #
    #   event.item.rendered_body
    #   #=> "<h1>Example</h1>"
    #
    # @example Get item body in Markdown.
    #
    #   event.item.body
    #   #=> "# Example"
    #
    # @example Get title of created item.
    #
    #   event.item.title
    #   #=> "Example title"
    #
    # @example Get item resource url.
    #
    #   event.item.url
    #   #=> "https://increments.qiita.com/qiitan/items/4bd431809afb1bb99e4f"
    #
    # @example A flag whether this item is co-edit mode.
    #
    #   event.item.coediting
    #   #=> false
    #
    # @example Get datetime when this item was created.
    #
    #   event.item.created_at
    #   #=> 2000-01-01T00:00:00+00:00
    #
    # @example Get datetime when this item was updated.
    #
    #   event.item.updated_at
    #   #=> 2000-01-02T00:00:00+00:00
    #
    # @example Get author id.
    #
    #   event.item.user.id
    #   #=> "qiitan"
    #
    # @example Get author name.
    #
    #   event.item.user.name
    #   #=> "Mr. Qiitan"
    #
    # @example Get tag names.
    #
    #   event.item.tags.map(&:id)
    #   #=> ["example"]
    #
    class ItemUpdated < Event
      # @return [Api::Resources::Item]
      alias_method :item, :resource
    end
  end
end
