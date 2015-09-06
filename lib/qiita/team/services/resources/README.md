# Qiita::Team::Services::Resources

There are several resources in `Qiita::Team::Services::Resources` module.
They are defined in Qiita core.

- [Team](#team)
- [User](#team)
- [Item](#item)
- [Project](#project)
- [Comment](#comment)

## Team

method  | type   | description
--------|--------|----------------
`#id`   | String | Unique team id.
`#name` | String | Team name.
`#url`  | String | Team root url.

### Example

```rb
team.id
#=> "increments"
team.name
#=> "Increments inc."
team.url
#=> "https://increments.qiita.com"
```

## User

method  | type   | description
--------|--------|---------------------
`#id`   | String | Unique user id.
`#name` | String | Human readable name.
`#url`  | String | Url to the user page.

### Example

```rb
user.id
#=> "qiitan"
user.name
#=> "Mr. Qiitan"
user.url
#=> "https://increments.qiita.com/qiitan"
```

## Item

method           | type          | description
-----------------|---------------|------------------------------------------
`#id`            | String        | Unique id.
`#title`         | String        | Item title.
`#body`          | String        | Item body in Markdown.
`#rendered_body` | String        | Item body in HTML.
`#url`           | String        | Item resource url.
`#coediting?`    | Boolean       | A flag whether this item is co-edit mode.
`#user`          | User          | User who created this item.
`#tags`          | Array<String> | Array of tag names.
`#created_at`    | Datetime      | Datetime when this item was created.
`#updated_at`    | Datetime      | Datetime when this item was last updated.

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
#=> <Qiita::Team::Services::Resouces::User>
item.tags
#=> ["example"]
item.created_at
#=> 2000-01-01T00:00:00+00:00
item.updated_at
#=> 2000-01-01T00:00:00+00:00
```

## Project

method           | type     | description
-----------------|----------|-------------------------------------
`#id`            | Fixnum   | Project unique id.
`#name`          | String   | Project name.
`#body`          | String   | Project body in Markdown.
`#rendered_body` | String   | Project body in HTML.
`#url`           | String   | Project resource url.
`#archived?`     | Boolean  | A flag whether this project has been archived.
`#created_at`    | Datetime | Datetime when this project was created.
`#updated_at`    | Datetime | Datetime when this project was last updated.

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

method           | type          | description
-----------------|---------------|----------------------------------------
`#id`            | String        | Comment unique id.
`#body`          | String        | Comment body in Markdown.
`#rendered_body` | String        | Comment body in HTML.
`#url`           | String        | Comment resource url.
`#item`          | Item, Project | Commented item or project.
`#created_at`    | Datetime      | Datetime when this comment was created.

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
