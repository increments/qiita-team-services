require "support/resources/item"

FactoryGirl.define do
  factory :item, class: Qiita::Team::Services::Resources::Item do
    user
    team { user.team }
    editor { build(:user, team: team) }
    id { "4bd431809afb1bb99e4#{generate(:id)}" }
    title "Example title"
    body "# Example"
    rendered_body "<h1>Example</h1>"
    url { "#{team.url}/#{id}" }
    coediting false
    tags { [build(:tagging)] }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
