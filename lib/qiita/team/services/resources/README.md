# Qiita::Team::Services::Resources

There are several resources in `Qiita::Team::Services::Resources` module.
They are defined in Qiita core.

- [TeamMember](#teammember)
- [Item](#item)
- [Project](#project)
- [Comment](#comment)

## TeamMember

method               | type   | description
---------------------|--------|---------------------
`#id`                | String | Unique user id.
`#name`              | String | Human readable name.
`#profile_image_url` | String | User icon url.
`#url`               | String | Url to the user page.
`#team`              | Team   | The team.

### Example

```rb
user.id
#=> "qiitan"
user.name
#=> "Mr. Qiitan"
user.profile_image_url
#=> "https://example.com"
user.url
#=> "https://increments.qiita.com/qiitan"
```

## Item

method        | type          | description
--------------|---------------|------------------------------------------
`#id`         | String        | Unique id.
`#title`      | String        | Item title.
`#raw_body`   | String        | Item body in Markdown.
`#body`       | String        | Item body in HTML.
`#url`        | String        | Item resource url.
`#coediting?` | Boolean       | A flag whether this item is co-edit mode.
`#user`       | TeamMember    | User who created this item.
`#team`       | Team          | The team.
`#tags`       | Array<String> | Array of tag names.
`#created_at` | Datetime      | Datetime when this item was created.
`#updated_at` | Datetime      | Datetime when this item was last updated.

### Example

```rb
item.id
#=> "4bd431809afb1bb99e4f"
item.title
#=> "Example title"
item.body
#=> "# Example"
item.rendered_body
#=> "<h1>Example</h1>
item.url
#=> "https://increments.qiita.com/qiitan/items/4bd431809afb1bb99e4f"
item.coediting?
#=> false
item.user
#=> <Qiita::Team::Services::Resouces::TeamMember>
item.tags
#=> ["example"]
item.created_at
#=> 2000-01-01T00:00:00+00:00
item.updated_at
#=> 2000-01-01T00:00:00+00:00
```

## Project

method        | type     | description
--------------|----------|-------------------------------------
`#id`         | Fixnum   | Project unique id.
`#name`       | String   | Project name.
`#raw_body`   | String   | Project body in Markdown.
`#body`       | String   | Project body in HTML.
`#url`        | String   | Project resource url.
`#archived?`  | Boolean  | A flag whether this project has been archived.
`#team`       | Team     | The team.
`#created_at` | Datetime | Datetime when this project was created.
`#updated_at` | Datetime | Datetime when this project was last updated.

### Example

```rb
project.id
#=> 1
project.name
#=> "Example project"
project.body
#=> "# Example"
project.rendered_body
#=> "<h1>Example</h1>"
project.url
#=> "https://increments.qiita.com/projects/1"
project.archived?
#=> false
project.created_at
#=> 2000-01-01T00:00:00+00:00
project.updated_at
#=> 2000-01-01T00:00:00+00:00
```

## Comment

method        | type          | description
--------------|---------------|----------------------------------------
`#id`         | String        | Comment unique id.
`#raw_body`   | String        | Comment body in Markdown.
`#body`       | String        | Comment body in HTML.
`#url`        | String        | Comment resource url.
`#item`       | Item, Project | Commented item or project.
`#user`       | TeamMember    | User who wrote the comment.
`#team`       | Team          | The team.
`#created_at` | Datetime      | Datetime when this comment was created.

### Example

```rb
comment.id
#=> "3391f50c35f953abfc4f"
comment.body
#=> "# Example"
comment.rendered_body
#=> "<h1>Example</h1>
comment.url
#=> "https://increments.qiita.com/qiitan/items/4bd431809afb1bb99e4f#comment-3391f50c35f953abfc4f
comment.item
#=> <Qiita::Team::Services::Resouces::Item>
comment.created_at
#=> 2000-01-01T00:00:00+00:00
```
