require "support/resources/comment"

FactoryGirl.define do
  factory :comment, aliases: [:item_comment], class: Qiita::Team::Services::Resources::Comment do
    item
    user { build(:user) }
    id { generate(:id) }
    body "# Example"
    rendered_body "<h1>Example</h1>"
    url { "#{item.url}#comment-#{id}" }
  end

  factory :project_comment, class: Qiita::Team::Services::Resources::Comment do
    item { build(:project) }
    user { build(:user) }
    id { generate(:id) }
    body "# Example"
    rendered_body "<h1>Example</h1>"
    url { "#{item.url}#comment-#{id}" }
  end
end
