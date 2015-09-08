require "support/resources/comment"

FactoryGirl.define do
  factory :comment, class: Qiita::Team::Services::Resources::Comment do
    item
    team { item.team }
    user { build(:user, team: team) }
    id { generate(:id) }
    body "# Example"
    rendered_body "<h1>Example</h1>"
    url { "#{item.url}#comment-#{id}" }
  end
end
